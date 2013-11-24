--- 
layout: post
title: Core Data Migration
---

One of the wonderful things about Core Data is that it provides a versioning mechanism that makes it easier to migrate your data if the model has changed from release to release. Apple has a guide called the <a href="http://developer.apple.com/documentation/Cocoa/Conceptual/CoreDataVersioning/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004403">"<em>Core Data Model Versioning and Data Migration Programming Guide</em>" </a> with useful info on this.

To use Core Data versioning support you need to be using Mac OS X v10.5 and your model file needs to be a **.xcdatamodeld** file type. That last "**d**" in the file type stands for directory; and it's a directory that contains **.xcdatamodel** files.

**Update:** If Mac OS X v10.6 is your baseline target operating system you should try <a href="http://developer.apple.com/mac/library/documentation/Cocoa/Conceptual/CoreDataVersioning/Articles/vmLightweight.html">lightweight migration</a> instead of following this article. Use the new <a href="http://developer.apple.com/mac/library/documentation/Cocoa/Reference/CoreDataFramework/Classes/NSPersistentStoreCoordinator_Class/NSPersistentStoreCoordinator.html#//apple_ref/doc/c_ref/NSInferMappingModelAutomaticallyOption">NSInferMappingModelAutomaticallyOption</a> migration option.

<img style="border: 2px solid black;" title="modeld" 
     src="/images/modeld.png" alt="modeld" />

Once you've created more than one version of your model you should support migrating old versions of the model to the new version. You can do this by passing the **NSMigratePersistentStoresAutomaticallyOption** option to **NSPersistentStoreCoordinator** when adding the persistent store and by creating a mapping model.

{% highlight objc %}
NSDictionary *optionsDictionary =
[NSDictionary
      dictionaryWithObject:[NSNumber numberWithBool:YES]
      forKey:NSMigratePersistentStoresAutomaticallyOption];

NSPersistentStore* store = [persistentStoreCoordinator
       addPersistentStoreWithType:NSXMLStoreType
       configuration:nil
       URL:url
       options:optionsDictionary
       error:&error];

if( store == nil ) {
    [[NSApplication sharedApplication] presentError:error];
    [[NSApplication sharedApplication] terminate:self];
}
{% endhighlight %}

Core Data will now magically convert the data from version 1 to version 2, if necessary when the program loads. You and your users will be happy. Everything is hunky-dory.

<img src="/images/mappingModel1.jpg" />

## Where's the Beef? ##
So far I've simply summarized Apple's documentation. What kind of blog is this anyway?

Well, automatic migration isn't completely automatic. Let's add a third version of the data model with another model mapping and see what happens.

<img src="/images/mappingmodel2.jpg" />

Okay, we've added a data model and a mapping model to that data model from the previous. We've set version three as the current version of the data model and now have two test cases to try.

- **Case 1:** Run with version 1 data and see if migration works
-	**Case 2:** Run with version 2 data and see if migration works

Testing shows that case 1 fails and case 2 passes. Case 1 fails because the automatic migration logic provided by Apple is very simple. It looks for a mapping model from the ol to the new version. If it can't find one then it stops.

<img src="/images/mappingmodel3.jpg"/>

To solve this problem you can modify the mapping from version 1 to 2 to go from version 1 to 3. The problem with this solution is that as you get more versions of your data model you will have to modify more mapping models. To be specific, if you have N data models you will need to configure N - 1 mapping models.

## Custom Migration ##
When N is large then so is N - 1, so modifying all those mapping models when we added one data model probably isn't the greatest solution; especially if we only added one attribute. We need custom migration code.

<img src="/images/mappingmodel4.jpg"  />

First we need to modify the appDelegate class in the standard Core Data generated project to use a migration class. We'll create a migration object and tell it to do the migration if it needs to be done.

{% highlight objc %}
SFMigrationManager* migrator = [[SFMigrationManager alloc]
      initWithModelName:@"SunFlower_DataModel"
      andXMLStoreURL:url];

BOOL latestVersion = [migrator migrateIfNeeded:&amp;error];
[migrator release];

if ( latestVersion ) {
  store = [persistentStoreCoordinator
           addPersistentStoreWithType:NSXMLStoreType
           configuration:nil
           URL:url
           options:nil
           error:&amp;error];
}

if (! latestVersion || store == nil){
  [[NSApplication sharedApplication] presentError:error];
  [[NSApplication sharedApplication] terminate:self];
}
{% endhighlight %}
Let's take a look at the **init** method for the class. The **init** method loads all the object models and figures out what model version the store is.
{% highlight objc %}
#define SFAssign(oldValue,newValue) \
  [ newValue retain ]; \
  [ oldValue release ]; \
  oldValue = newValue;

- (id)initWithModelName:(NSString*)name
      andXMLStoreURL:(NSURL*)url {

  if ( (self = [super init]) ){
    SFAssign(storeURL, url);

    if ( ! [self loadObjectModels:name] ||
         ! [self determineModelVersion] ) {
      [self release];
      return nil;
    }
  }

  return self;
}
{% endhighlight %}
The object models are loaded by loading the file VersionInfo.plist, which is embedded in your applications bundle, and getting a dictionary of NSManagedObjectModel\_VersionHashes. Dictionaries are not ordered so we need to sort the dictionary and then finally we create **NSManagedObjectModel** objects and put them in an array in their sorted order.

{% highlight objc %}
-(BOOL)loadObjectModels:(NSString*)modelName {

  NSString* momdPath = [[NSBundle mainBundle] pathForResource:modelName ofType:@"momd"];
  NSBundle* modelBundle = [NSBundle bundleWithPath:momdPath];
  NSString* plistPath = [modelBundle pathForResource:@"VersionInfo" ofType:@"plist"];
  NSData* plistData = [NSData dataWithContentsOfFile:plistPath];
  NSString *error;

  NSDictionary* versionInfo = [NSPropertyListSerialization propertyListFromData:plistData
                                                 mutabilityOption:NSPropertyListImmutable
                                                           format:NULL
                                                 errorDescription:&amp;error];
  if ( error ) {
    NSLog(@"An error occurred retrieving versionInfo --&gt; %@", error);
    return NO;
  }

  NSDictionary* versionDict 
    = [versionInfo valueForKey:@"NSManagedObjectModel_VersionHashes"];

  objectModels = [[NSMutableArray alloc] initWithCapacity:[versionDict count]];
  NSArray* sortedMomList = [[versionDict allKeys] sortedArrayUsingFunction:nameSort context:NULL];

  for (NSString* modelName in sortedMomList) {
    NSString* modelPath = [modelBundle pathForResource:modelName ofType:@"mom"];
    NSManagedObjectModel* model =
         [[NSManagedObjectModel alloc] initWithContentsOfURL: [NSURL fileURLWithPath: modelPath]];
    [objectModels addObject:model];
    [model release];
  }

  return YES;
}
{% endhighlight %}
Determining the model version of the persistent store is as simple as iterating through the array of ordered object models until we find the correct one.
{% highlight objc %}
-(BOOL)determineModelVersion {
  NSError* error;
  NSDictionary *storeMetadata = [NSPersistentStoreCoordinator
                                 metadataForPersistentStoreWithURL:storeURL
                                 error:&amp;error];
  if ( ! storeMetadata ) {
    return NO;
  }

  for( NSManagedObjectModel* model in objectModels ) {
    if ([model isConfiguration:nil compatibleWithStoreMetadata:storeMetadata] ) {
      currentStoreModel = [objectModels indexOfObject:model];
      return YES;
    }
  }

  return NO;
}
{% endhighlight %}
Finally, here is the core of the migration class that incrementally converts the persistent store to the latest version.
{% highlight objc %}
- (BOOL)migrationNeeded {
  return ! ( currentStoreModel == [objectModels count] );
}

- (BOOL)migrateIfNeeded:(NSError**)error {

  if ( ! [self migrationNeeded] ) {
    return YES; }

  // Backup the store before we do anything
  NSString* backupFilePath = [[storeURL path] stringByAppendingString:@".backup"];
  if( ![self overWriteCopy:[storeURL path] to:backupFilePath error:error] ) {
    return NO;
  }

  NSDictionary *opts =
  [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]
                              forKey:NSMigratePersistentStoresAutomaticallyOption];
  NSInteger i;
  NSURL* tempURL = [NSURL fileURLWithPath:[[storeURL path] stringByAppendingString:@".temp"]];

  for( i = currentStoreModel; i &lt; [objectModels count] - 1; i++ ) {     // Migrate the store to a temp file.     // SunFlower.xml --&gt; SunFlower.xml.temp
    BOOL migrationSuccess = [[self migrationManagerForIndex:i]
                               migrateStoreFromURL:storeURL type:NSXMLStoreType options:opts
                               withMappingModel:[self mappingModelForIndex:i]
                               toDestinationURL:tempURL
                              destinationType:NSXMLStoreType destinationOptions:opts
                               error:error];

    // Revert and return if:
    // 1.) The migration failed.
    // 2.) The temp file could not be copied over the original.
    // 3.) The temp file could not be deleted.
    if (! migrationSuccess ||
        ! [self overWriteCopy:[tempURL path] to:[storeURL path] error:error] ||
        ! [[NSFileManager defaultManager]  removeItemAtPath:[tempURL path] error:error]) {
      // Revert to backup file and exit
      // Not passing an error because we want to propogate the previous error.
      [self overWriteCopy:backupFilePath to:[storeURL path]  error:NULL];
      return NO;
    }
  }

  return YES;
}
{% endhighlight %}
Happy Koding!
