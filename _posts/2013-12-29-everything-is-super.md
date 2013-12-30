---
layout: custom
title:  "Everything is Just Super"
excerpt: A look at superhero movies over the last three decades.

---

<script src="/js/d3.v3.min.js" type="text/javascript"></script>
<script src="/js/PPUtils.js" type="text/javascript"></script>
<script src="/js/PPGraph.js" type="text/javascript"></script>

<style>

div#demographics { background-color:#EEE; text-align:center; 
padding-top:20px; padding-bottom:20px;}

div.nav-container div.title {
  position: relative;
  font-size:100%;
  top:0px; left:0px;
}

#movieHeader, #movieData { font: 15px Arial, sans-serif; 
  width: 760px;
}

#movieHeader table, #movieData table { border-collapse: collapse; }
#movieHeader table th.header { text-align:center;background:#CCC; }

#movieHeader table td, #movieData table td { 
  border: 1px solid #ddd; 
  padding-left:10px;
}

.yearRow { background: #e8e8e8; }
.flop { color:#fff; background: #F00; }

#movieHeader, #graphMetaData, #superBarGraph { width: 760px; margin-left: auto; margin-right: auto; }

#graphMetaData { 
 -webkit-transition: all 1s ease;
position:relative; height:200px; overflow-y:scroll; 
 }

#superBarGraph rect { fill: steelblue; }
.barData { fill: white; }

#superBarGraph text {
  color: black;
  font: 10px sans-serif;
  text-anchor: middle;
}
.axis text { font: 10px Arial, sans-serif; }

#superBarGraph rect:hover {
  fill: brown;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.axis { shape-rendering: crispEdges; }
.x.axis line { stroke: lightgrey; }
.x.axis .minor { stroke-opacity: .5; }
.x.axis path { display: none; }

</style>

<script>


function type(d) {
  d.Total= +d.Total;     // coerce to number
  d.Year=new Date(d.Year,1,1,1,1,1,1);
  return d;
}

// scrollTop isn't a css3 property so unfortunately
// we can't use a css3 transformation
function animateScroll( frame, topLoc) {
 var origTop = frame.scrollTop;
 var totalDelta = origTop - topLoc;
 var count = 10;
 var delta = ~~(totalDelta / count);

 var interval = window.setInterval( function()
 {
  count--;
 
  frame.scrollTop = (frame.scrollTop - delta);

  if ( count == 0 ) {
    clearInterval(interval);
    frame.scrollTop = topLoc;
  }

 }, 30);

}

function handleClick(d) { 
 var yearId = d.Year.getFullYear();
 // TODO -- timeline appears to be using JQuery....
 var frame = document.getElementById("graphMetaData");
 var elem = document.getElementById(yearId);
 animateScroll( frame, elem.offsetTop);

}

function yFunc(d) { return d.Total; }

function getXScale(data) {
  return d3.time.scale().domain([data[0].Year, data[data.length-1].Year] );
}

function getYScale(data) {
  return d3.scale.linear().domain([0, d3.max(data, yFunc) ] )
}



var options = {};
options.d = { 'w': 760, 'h': 320, 'margin':80 };
options.showYaxis = false;
options.showXaxis = true;
options.barTextValues = true;
options.typeFunc = type;
options.getXScale = getXScale;
options.getYScale = getYScale;
options.yFunc = yFunc;
options.barClick = handleClick;

new PPBarGraph("superBarGraph", "/data/Superhero/yearlyTotal.csv",  options);

</script>

<section>
<article class="skinny" >
<div class="postContent">

There seem to be more and more superhero movies being released every year. This  is either a blessing, if you are a twelve year-old boy, or a middle aged man with the maturity of a tween, or a curse, if you're a snooty intellectual.  I'm not a fan of the superhero movie genre and recently started letting it be known by vehemently refusing to watch any more superhero movies in the theatres.  This is not an out right refusal to watch superhero movies, just an avoidance to pay top dollar at the theatre to watch superheros.  Recently the love of my life wanted to see the new Thor movie but we compromised in the direction of the second Hunger Games movie (Catching Fire) due to my silent and highly ineffective protest against these blockbuster behemoths.

Besides the fact that I'm a killjoy, spoil sport, and an old codger, do I have a right to complain?  Are there really more super hero movies being released? 
This is an easy question to answer with a little determination. So I found a website that listed movie releases by year and created a magical spreadsheet, wrote a blog post, made some chart porn, and will talk about said chart porn until the cows go home.  Don't take this as the definitive list, but it's in the ballpark. 

While compiling the data I had to reflect on the actual definition of a superhero.  I decided to keep it to classic super hero movies with a decent theatrical release, anything that felt borderline was left out of the final tally but kept in the list of superhero movies by year with a question mark beside the title. An example of something borderline would be the Conan movies from the 1980s, or the Toxic Avenger B-movies from the same decade.  Conan, although a super guy in all respects originates from pulp fiction magazines in the 30's while the Toxic Avenger is a B-movie, albeit an unusually successful one.  I also ignored the full-length animated Batman movie, Mask of the Phantasm(1993), but inconsistently included MegaMind(2010), and The Incredibles(2004).  This could be my subconcious mind attempting to skew the stats to show that, yes, there have been more superhero movies released lately.  I did, however, include comedies that are superhero themed: Meteor Man(93), Blankman(94), Mystery Men(99), My Super Ex-Girlfriend (2006). But again, Superhero Movie(2008) has been omitted, because well, I saw that one and it's really horrible and I'm hoping to save you some time.

</div>
</article>
</section>

<div id="superBarGraph"></div>

<div >
  <table id="movieHeader" >
    <col width="410">
    <col width="150">
    <col width="100">
    <col width="100">
    <tbody>
     <tr>
       <th></th>
       <th colspan=2 class="header">Millions</th>
       <th></th>
     </tr>
     <tr>
       <th class="header">Movie</th>
       <th class="header">Production Cost</th>
       <th class="header">Box Office</th>
       <th class="header">Return Rate</th>
     </tr>
   </table>
</div>
 
<div id="graphMetaData">
  <table id="movieData" >
    <col width="410">
    <col width="150">
    <col width="100">
    <col width="100">
    <tbody>
    <tr id="1978" class="yearRow"><td colspan=4>1978</td></tr>
    <tr><td>Superman</td><td>55</td><td>300</td><td>5.45</td></tr>
    <tr id="1980" class="yearRow"><td colspan=4>1980</td></tr>
    <tr><td>Flash Gordon</td><td>20</td><td>27</td><td>1.35</td></tr>
    <tr><td>Hero at Large</td><td>?</td><td>15</td><td>?</td></tr>
    <tr id="1981" class="yearRow"><td colspan=4>1981</td></tr>
    <tr><td>Superman II</td><td>54</td><td>108</td><td>2</td></tr>
    <tr><td>Condorman</td><td>?</td><td>?</td><td>?</td></tr>
    <tr id="1982" class="yearRow"><td colspan=4>1982</td></tr>
    <tr><td>Conan The Barbarian?</td><td>16</td><td>130</td><td>8.13</td></tr>
    <tr id="1983" class="yearRow"><td colspan=4>1983</td></tr>
    <tr><td>Superman III</td><td>39</td><td>70</td><td>1.79</td></tr>
    <tr id="1984" class="yearRow"><td colspan=4>1984</td></tr>
    <tr><td>SuperGirl</td><td>35</td><td>14</td><td class="flop">0.4</td></tr>
    <tr><td>Conan The Destroyer?</td><td>18</td><td>31</td><td>1.72</td></tr>
    <tr id="1985" class="yearRow"><td colspan=4>1985</td></tr>
    <tr><td>Red Sonja?</td><td>17.9</td><td>7</td><td class="flop">0.39</td></tr>
    <tr id="1987" class="yearRow"><td colspan=4>1987</td></tr>
    <tr><td>Superman IV: The Quest For Peace</td><td>17</td><td>15</td><td class="flop">0.88</td></tr>
    <tr id="1989" class="yearRow"><td colspan=4>1987</td></tr>
    <tr><td>Batman</td><td>48</td><td>411</td><td>8.56</td></tr>
    <tr><td>Toxic Avenger?</td><td>2.3</td><td>0.8</td><td class="flop">0.35</td></tr>
    <tr id="1990" class="yearRow"><td colspan=4>1990</td></tr>
    <tr><td>Darkman</td><td>16</td><td>49</td><td>3.06</td></tr>
    <tr><td>Captain America (direct to video in 92)</td><td>10</td><td>?</td><td>?</td></tr>
    <tr id="1991" class="yearRow"><td colspan=4>1991</td></tr>
    <tr><td>The Rocketeer</td><td>42</td><td>62</td><td>1.48</td></tr>
    <tr><td>The Punisher (direct to video)</td><td>7</td><td>?</td><td>?</td></tr>
    <tr id="1992" class="yearRow"><td colspan=4>1992</td></tr>
    <tr><td>Batman Returns</td><td>80</td><td>267</td><td>3.34</td></tr>
    <tr id="1993" class="yearRow"><td colspan=4>1993</td></tr>
    <tr><td>Meteor Man</td><td>30</td><td>8</td><td class="flop">0.27</td></tr>
    <tr id="1994" class="yearRow"><td colspan=4>1994</td></tr>
    <tr><td>The Shadow</td><td>40</td><td>48</td><td>1.2</td></tr>
    <tr><td>Blankman</td><td>1</td><td>8</td><td>8</td></tr>
    <tr><td>The Mask</td><td>23</td><td>351</td><td>15.26</td></tr>
    <tr id="1995" class="yearRow"><td colspan=4>1995</td></tr>
    <tr><td>Batman Forever</td><td>100</td><td>336</td><td>3.36</td></tr>
    <tr><td>Judge Dredd</td><td>90</td><td>113</td><td>1.26</td></tr>
    <tr id="1996" class="yearRow"><td colspan=4>1995</td></tr>
    <tr><td>The Phantom</td><td>45</td><td>17</td><td class="flop">0.38</td></tr>
    <tr id="1997" class="yearRow"><td colspan=4>1997</td></tr>
    <tr><td>Batman and Robin</td><td>140</td><td>113</td><td>1.7</td></tr>
    <tr><td>Spawn</td><td>40</td><td>87</td><td>2.17</td></tr>
    <tr id="1998" class="yearRow"><td colspan=4>1998</td></tr>
    <tr><td>Blade</td><td>45</td><td>131</td><td>2.91</td></tr>
    <tr id="1999" class="yearRow"><td colspan=4>1999</td></tr>
    <tr><td>Mystery Men</td><td>68</td><td>33</td><td class="flop">0.49</td></tr>
    <tr id="2000" class="yearRow"><td colspan=4>2000</td></tr>
    <tr><td>X-Men</td><td>75</td><td>296</td><td>3.95</td></tr>
    <tr><td>Unbreakable</td><td>75</td><td>248</td><td>3.31</td></tr>
    <tr><td>The Specials</td><td>1</td><td>0.013</td><td class="flop">0.01</td></tr>
    <tr id="2002" class="yearRow"><td colspan=4>2002</td></tr>
    <tr><td>Blade 2</td><td>55</td><td>155</td><td>2.82</td></tr>
    <tr><td>Spider-man</td><td>140</td><td>822</td><td>5.87</td></tr>
    <tr id="2003" class="yearRow"><td colspan=4>2003</td></tr>
    <tr><td>Daredevil</td><td>78</td><td>178</td><td>2.29</td></tr>
    <tr><td>X2: X-Men United</td><td>110</td><td>408</td><td>3.71</td></tr>
    <tr><td>The Hulk</td><td>137</td><td>245</td><td>1.79</td></tr>
    <tr id="2004" class="yearRow"><td colspan=4>2004</td></tr>
    <tr><td>Hellboy</td><td>66</td><td>99</td><td>1.5</td></tr>
    <tr><td>The Punisher</td><td>33</td><td>54.5</td><td>1.65</td></tr>
    <tr><td>Spider-Man 2</td><td>200</td><td>784</td><td>3.92</td></tr>
    <tr><td>Catwoman</td><td>100</td><td>84</td><td class="flop">0.84</td></tr>
    <tr><td>The Incredibles</td><td>92</td><td>631</td><td>6.86</td></tr>
    <tr><td>Blade: Trinity</td><td>65</td><td>128</td><td>1.97</td></tr>
    <tr id="2005" class="yearRow"><td colspan=4>2005</td></tr>
    <tr><td>The Adventures of Sharkboy and LavaGirl</td><td>50</td><td>69</td><td>1.38</td></tr>
    <tr><td>Batman Begins</td><td>150</td><td>374</td><td>2.49</td></tr>
    <tr><td>Fantastic Four</td><td>100</td><td>330</td><td>3.3</td></tr>
    <tr><td>Elektra</td><td>43</td><td>57</td><td>1.33</td></tr>
    <tr id="2006" class="yearRow"><td colspan=4>2006</td></tr>
    <tr><td>X-Men:The Last Stand</td><td>210</td><td>459</td><td>2.19</td></tr>
    <tr><td>Superman Returns</td><td>204</td><td>391</td><td>1.92</td></tr>
    <tr><td>My Super Ex-Girlfriend</td><td>30</td><td>61</td><td>2.03</td></tr>
    <tr id="2007" class="yearRow"><td colspan=4>2007</td></tr>
    <tr><td>Ghost Rider</td><td>210</td><td>459</td><td>2.19</td></tr>
    <tr><td>Spider-Man 3</td><td>258</td><td>890</td><td>3.45</td></tr>
    <tr><td>Fantastic Four: Rise of the Silver Surfer</td><td>130</td><td>289</td><td>2.22</td></tr>
    <tr id="2008" class="yearRow"><td colspan=4>2008</td></tr>
    <tr><td>Iron Man</td><td>140</td><td>585</td><td>418</td></tr>
    <tr><td>The Incredible Hulk</td><td>150</td><td>263</td><td>1.75</td></tr>
    <tr><td>Hancock</td><td>150</td><td>624</td><td>4.16</td></tr>
    <tr><td>Hellboy II</td><td>85</td><td>160</td><td>1.88</td></tr>
    <tr><td>The Dark Knight</td><td>185</td><td>160</td><td>1.88</td></tr>
    <tr><td>Punisher: War Zone</td><td>35</td><td>10</td><td>0.29</td></tr>
    <tr><td>The Spirit</td><td>60</td><td>39</td><td>0.65</td></tr>
    <tr id="2009" class="yearRow"><td colspan=4>2009</td></tr>
    <tr><td>Push</td><td>38</td><td>49</td><td>1.29</td></tr>
    <tr><td>Watchmen</td><td>130</td><td>185</td><td>1.42</td></tr>
    <tr><td>Dragonball: Evolution</td><td>30</td><td>57</td><td>1.9</td></tr>
    <tr><td>X-Men Origins: Wolverine</td><td>150</td><td>373</td><td>2.49</td></tr>
    <tr id="2010" class="yearRow"><td colspan=4>2010</td></tr>
    <tr><td>Kick-ass</td><td>28</td><td>96</td><td>3.43</td></tr>
    <tr><td>Defendor</td><td>4</td><td>0.044</td><td class="flop">0.01</td></tr>
    <tr><td>Paperman?</td><td>?</td><td>?</td><td>?</td></tr>
    <tr><td>Iron Man 2</td><td>200</td><td>623</td><td>3.12</td></tr>
    <tr><td>Mega Mind</td><td>130</td><td>321</td><td>2.47</td></tr>
    <tr id="2011" class="yearRow"><td colspan=4>2011</td></tr>
    <tr><td>The Green Hornet</td><td>120</td><td>227</td><td>1.89</td></tr>
    <tr><td>I Am Number Four</td><td>50</td><td>150</td><td>3</td></tr>
    <tr><td>Super</td><td>2.5</td><td>0.327</td><td class="flop">0.3</td></tr>
    <tr><td>Thor</td><td>150</td><td>449</td><td>2.99</td></tr>
    <tr><td>X-Men: First Class</td><td>140</td><td>353</td><td>2.52</td></tr>
    <tr><td>Green Lantern</td><td>200</td><td>219</td><td>1.1</td></tr>
    <tr><td>Captain America: The First Avenger</td><td>140</td><td>370</td><td>2.64</td></tr>
    <tr id="2012" class="yearRow"><td colspan=4>2012</td></tr>
    <tr><td>Ghost Rider: Spirit of Vengance</td><td>57</td><td>132</td><td>2.32</td></tr>
    <tr><td>Chronicle</td><td>12</td><td>126</td><td>10.5</td></tr>
    <tr><td>The Avengers</td><td>220</td><td>1519</td><td>6.9</td></tr>
    <tr><td>The Amazing Spider-Man</td><td>230</td><td>752</td><td>3.27</td></tr>
    <tr><td>The Dark Knight Rises</td><td>230</td><td>1084</td><td>4.71</td></tr>
    <tr><td>Dredd</td><td>45</td><td>41</td><td class="flop">0.91</td></tr>
    <tr id="2013" class="yearRow"><td colspan=4>2013</td></tr>
    <tr><td>Iron Man 3</td><td>200</td><td>1215</td><td>6.08</td></tr>
    <tr><td>Man of Steel</td><td>225</td><td>663</td><td>2.95</td></tr>
    <tr><td>The Wolverine</td><td>120</td><td>414</td><td>3.45</td></tr>
    <tr><td>Kick Ass 2</td><td>28</td><td>60</td><td>2.14</td></tr>
    <tr><td>Thor: The Dark World</td><td>170</td><td>610</td><td>3.59</td></tr>
    </tbody>
  </table>
</div>
</div>



<section>
<article class="skinny" >
<div class="postContent">


After tallying the results, it appears my assumption was correct.  There are, in fact, more superhero movies lately.  We've gone from having one superhero movie a year at most in the early 80s to 3-7 superhero movies a year.  More than a three-fold increase.  Most likely, these big budget productions get big budget dollar returns.  Well, we have an interweb, let's compare production costs and revenues for all the superhero movies in the past thirty years. 

I've tabulated the production cost and revenue return, rounded to the nearest million, hey it's not my money.  I've also divided the revenue by the cost to get an approximate rate of return.  I grabbed most of the numbers from wikipedia,  I have no idea if the numbers have been adjusted for inflation, but that's the point of the rate of return figure. A rate of return metric doesn't change based on inflation.  It definitely helps put things in perspective.  You'll read articles where people go gaga over the success of The Avengers, since it made 1.5 billion dollars.  1.5 billion isn't anything to shake a stick at but it did cost 220 million to make and garnered a 6.9 return rate.  So The Avengers is the fourth most successful movie if we use rate of return as our measuring stick.  The Mask, with it's measly 23 million dollar budget  15.6 return rate takes the prize for most successful superhero movie.  You give me a dollar, I go make a movie, now we have 15.60. 

If you don't consider The Mask superhero enough for you (it is a comedy), The Avengers is still not the most sucessful superhero movie because Chronicle had a return rate of 10.5 and  the 1989 version of Batman had a return rate of 8.56. 

Now, looking at the return rate of movies isn't the be all end all. Movies aren't publicly traded companies that have to declare their earnings every quarter.  I'm not even sure why production budget numbers are announced other than for people to brag about how much movie x will cost.  Not only that, multi-million dollar projects have a tendency to go over budget, by millions. And when that happens, no one celebrates it.  It's possible that the official wikipedia numbers that float around are from announcements that occurred before production even starts. 

Marketing costs for these movies is large, and not included in the published production cost.  The Avengers, our most recent poster child for superhero movies reportedly cost $100 million to market.  If we factor that into our return rate, 1519/(220 + 100) = 4.75, then the investment return rate isn't as good as you initially thought.

Movies also find other ways to recoup costs that aren't totalled with the box office numbers, and production costs.  Locales use tax breaks as an incentive to attract movie productions.  The sequel to Man of Steel will be getting a $35 million to shoot in Detroit.  The state of New Mexico subzidized The Avengers to the tune of $22 million.

Product placement is also big in these types of big budget movies.  Man of Steel, which cost $225 million to make, reportedly had $160 million in product placement.  Which is impressive, considering it is 70% of the production budget.  It's also unclear if the product placement numbers quoted on the interwebs solely include products that have been placed in the movie or if it also includes cross-promotions, such as cans of soda with Superman on them.

Another common misconception is that the huge box office numbers that are thrown at you are what the studio made.  But they are box office numbers, not pure profit, the theatre takes their cut, which is estimated to be 50%, and the studio gets the rest.  So let's look at our Avengers poster child again and see what the return rate might be. (1519\*0.5)/(220 + 100) = 2.37.  So our initial naive, return rate is nowhere near this current estimate.  Don't forget to remove the $22 million tax break, and add whatever product placement/cross promotion revenue that was received.

So studios are definitely making money, but it's just not that easy to figure out how much. Box office numbers although not totally meaningless, don't tell us at all how much a movie made, but it's an common news story because people enjoy hearing big unfathomable numbers. The true return from a movie includes, box office, broadcast rights (i.e. NetFlix), tax rebates, product placement, cross-promotion, rental revenue and probably some other stuff we haven't thought about.

All this money talk doesn't completely explain an increase in superhero movies.  Yeah, superhero movies make money, but so do other types of movies.  One explanation people like to throw out there is international markets.  Also known as "Yeah, but China" explanation.  The reasoning goes that movies have to translate well across cultural boundaries. Explosions, fisticuffs, robots that transform, natural disasters, and men running around in full-body spandex suits apparently translate better around the world.  Essentially anything that relies more on visuals than character development is expected work better internationally.  If there isn't a lot of dialog then there isn't as much that can get lost in translation.  This is partially true.  I don't know the particulars, but apparently the studios don't have the same sweet deal internationally as they do domestically.

</div>
</article>
</section>

<div id="superheroTimeline"></div>

<script type="text/javascript">
        var timeline_config = {
            width:              '100%',
            height:             '600',
            source:             '/data/Superhero/timeline.json',
            embed_id:           'superheroTimeline',               //OPTIONAL USE A DIFFERENT DIV ID FOR EMBED
            //debug:              true,                           //OPTIONAL DEBUG TO CONSOLE
            maptype:            'watercolor',                   //OPTIONAL MAP STYLE
            css:                '/js/timeline/css/timeline.css',     //OPTIONAL PATH TO CSS
            js:                 '/js/timeline/js/timeline-min.js'    //OPTIONAL PATH TO JS
        }
</script>

<script type="text/javascript" src="/js/timeline/js/storyjs-embed.js"></script>

<section>
<article class="skinny" >
<div class="postContent">

The best argument I've found to support the rash of superhero movies is demographics.  Traditionally younger people have more free time, disposable income, and go to the movies more often, especially in the summer when school's out (this is complete conjecture by the way).  Younger minds are also probably more apt to be swayed by flashy movie trailers (more conjecture), that show you all the good parts before you get to the theatre. Although the 12-17 and 18-24 demographics are only 11% and 12% respectively the appear to influence/drag along their parents to the movies, as somebody has to drive.  It would be interesting to see the demographic percentages broken down by season instead of tallied for the whole year.

</div>
</article>
<div id="demographics">
##US/Canada Age Group Movie Demographics##
[Source][demographics]

<img src="/images/superhero/demographics.gif" />

</div>

<article class="skinny" >
<div class="postContent">



When researching this information on the web, because everything is on the interwebs, unless it's not there. I found it difficult to find information on movies from the 70s and 80s.  I did find some interesting information about the origin of the summer blockbuster,  although most search results currently associate the word blockbuster with the former movie rental outfits recent demise.  The summer blockbuster didn't start until the mid-seventies.  People associated the summer with camping and going to the beach.  Movies were generally considered a winter time thing when the weather wasn't as agreeable.  But the release of Jaws in 1975 changed things.  It was released in the summer when people were at the beaches to make it feel more real.  With the advent of the air-conditioner, people realized that it could be enjoyable to watch a movie in the summer and the summer blockbuster was born.  A common complaint is that Hollywood is soooo forumulaic, but these formulas as generally stumbled upon accidently.  And let's be honest, if you were spending multi-millions to produce a movie what would you do?  Produce something formulaic that has a higher chance of succeeding, or take a risk on something completely unproven.

##DC versus Marvel##

Not all superhero movies are based on characters by DC or Marvel but they comprise the majority of the biggest superhero blockbusters.  Historically DC characters dominated the genre of superhero summer blockbusters, starting with the original Superman released in 1978.  The early eighties were dominated with Superman movies, each one making progressively less money.  The still born birth of Supergirl in 1984 did nothing to disuade the creation of Superman IV which was also a disaster.  But Tim Burton's Batman in 1989 cemented people's faith that superhero movies can have a huge payout.  Again, each subsequent Batman movie cost significantly more to produce and brought in less money.

Marvel character movies are essentially absent until Blade is released in 1998.  After seeing the success of Superman, Marvel licensed the film rights to their characters but there were many false starts before movies with characters owned by Marvel came to the stage.  Not for any lack of trying.  There is a Captain America and Punisher movie that were produced in the early 90's, were intended for the big screen, but relegated to a direct to video release because they were complete train wrecks. 

At first glance, it may seem that Marvel smells the money, and like a dude that arrives late to the party, is pounding back lagers in an effort to get caught up.  DC is a very simple story.  Warner Brothers completely owns DC, has for years, and can make whatever movie it wants with characters in the DC universe.  Marvel, although, bought by Disney in 2009, who has the resources to produce movies,  has been tangled in web like licesening deals for years.  I was surprised, because I'm not a comic book nerd, to find out that three studios currently have rights to Marvel characters.  Sony owns Spider-Man, Ghost Rider and all the related characters.  Don't ask me why they make Ghost Rider movies,  probably the same reason they make Judge Dredd movies.  Fox owns X-Men, Daredevil, Elektra, and Fantastic Four, and everything else is owned by Marvel Studios.  There may be some other weird licensing deals but this is a good view of the current landscape.

The fact that there are three major studios that own the rights to Marvel characters partially explains the increase in superhero movies each summer.  Four major studios, if we include DC/Time Warner, fighting for your superhero dollars.  Not only that, some of the licensing contracts expire if a movie is not made with the character after so many years.  This could explain why Sony only left a five year gap between the Spider-Man and The Amazing Spider-Man reboot.  Hmmmm, that's another nerdy statiscal thing we can look at.  The years between reboots of major superhero characters.

##Reboots##

Reboots are generally reserved for la créme de la créme, something that made money in the past and has a very good chance of doing so again.  Batman, Superman, Spiderman, and wait, what?  Judge Dredd.  After the 1995 version with Stallone it's embarrasing to see that another attempt was made at resurrecting Dredd.  What's even more interesting is that Dredd comes from neither the DC or Marvel universe, it is an island unto itself. 

After the disaster that was The Quest for Peace and the easily forgotten Superman Returns in 2006 we have almost 20 years before a reboot.  Superman Returns wasn't successful enough for a sequel, but Time Warner took another kick at the can this year, so it took seven years for the second reboot. 

Batman got a reboot with Tim Nolan's Batman Begins eight years after the train wreck that was Batman and Robin.  Generally the pattern with superhero movies with sequels is that the first makes oodles of cash and then the studio tries to reproduce the result, or milk the franchise for everything possible with sequels. Prime examples are the original Superman series, the 1989 Batman series, Spiderman and the X-Men series.  The Dark Knight trilogy bucks this trend, the first movie making nowhere near what the second two made.

So seven to eight years seems to be near the limit any conserative person would expect you should wait before rebooting a superhero franchise.  Warner seems to like to wait at least that long when licking it's wounds from an unsuccessful Superman movie.  But then Sony decided to do a reboot with The Amazing Spider-Man just five years after Spider-Man 3, a play that was so obviously a money-grab that William Dafoe called them out on it, calling it "...a cynical approach to making money!".  The Amazing Spider-Man also made less money than Spider-Man 3 following the box office pattern of a sequel and not a reboot.  Sony probably could have had a box office hit with Amazing Spider-Man if they had waited a minimum 8-10 years, which would be enough time for the old series to start looking dated, and enough time for the children who watched the original series to grow up and start having kids, who they could then take to the cinema.

2014 will be no different for superhero movies than any year in the last decade, chalk full of them.  A quick look tells me that there are 4 superhero movies scheduled: The Amazing Spider-man 2, Captain America: The Winter Soldier, Guardians of the Galazy, and X-Men: Days of Future Past.  I will be continuing my silent protest in silence for the year 2014, but may have to break that protest in 2015 for Ant-Man,  I guess I'm just a sucker for Paul Rudd.

</div>
</article>
</section>

##References##
- [Who Goes to the Movies? Moviegoers Stats from 2010 | Women and Hollywood] [demographics]
- [Superhero films | Wikipedia] [wikilist]
- [Why Journalists Don't Understand Hollywood] [journalists]

[demographics]: http://blogs.indiewire.com/womenandhollywood/who_goes_to_the_movies_moviegoers_stats_from_2010
[wikilist]: http://en.wikipedia.org/wiki/Category:Superhero_films 
[journalists]: http://edjayepstein.blogspot.ca/2010/01/why-journalists-dont-understand.html 
