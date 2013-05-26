\chapter{算法评估}
\label{chap:eval}

<!-- Evaluation
====
\label{sec:eval}
 -->
In order to evaluate that GameRank has good performance, we conduct a
series of experiments. In this section we evaluate GameRank, by comparing its results on MLB data with some prestigious
ranking approaches. These ratings include ESPN Ratings\cite{espn}, Elias
Ratings, Inside Edge Rating, and The Baseball Encyclopedia Rating, which
are all introduced in \cite{ratings}.

We collect ranking results of all these metrics in \cite{ranking_data},
including rankings from year 2008 to 2013. We do not have play-by-play
data for 2013 on Retrosheet\cite{retrosheet}, so we only compare the
rankings from 2008 to 2012.


Introduction on Different Ratings
====

In ESPN Ratings, batters, starting pitchers and relievers are separated
into different ranking groups.  For each group, it calculates the
weighted average of all the factors as a single score to describe the
players' value. As an example, the ESPN rating of batters are calculated
by gathering the following factors:  batting bases accumulated, runs
produced, OBP, BA, HRs, RBIs, runs, hits, net steals, team win
percentage, difficulty of defensive position, etc. It includes more than
10 factors. Both of the other groups also include more than 5 factors.

Similarly, The Baseball Encyclopedia Ratings is also based on "linear
weights that assigns a value to every event in the course of a baseball
game."

Inside Edge Rating is the most related to GameRank: it uses a pitch-by-
pitch rather than play-by-play method, where every pitch is given a
value, and winners in these competitions will gain some fixed points and
losers will lose points. But it still misses the relationships between
different players: winning a top batter and a bottom batter would give
same points to a pitcher. So it still ignores the impact of opponents in
evaluating players.

Elias Ratings evaluate the difference in the team's chance to win, by
simulating the game before and after the involvement of certain batters
and pitchers, in the context of game situations and stadium effects. Its
ratings are produced by large-scale computer simulations over many
innings of games.

We argue that all those ratings are unnatural and inadequate: some of
them involves computing the weighted average of many statistics of
players, simply summing up a bunch of indicators; others are more
complex methods but still ignoring the impact of opponents on evaluating
players. None of those indicators can take the detailed relationships
among players into consideration.

What is worse, a lot of players fail to get a score according to these
algorithms, thus a large number of players cannot get a rank, while our
GameRank algorithm can rank all the players according to game data. In
Table \ref{table:ranked_players}, we show the number of ranked pitchers
and batters of all the metrics. Note that GameRank can measure both
pitching and batting abilities for all players, but not all players are
batters as well as pitchers. Most batters do not pitch, and a few
pitchers do not hit. We still measure their both abilities, and list them
in the table.

Compared to other Ratings, our algorithm is simpler, more natural,
considers the impact of opponents in player evaluation, and covers a
larger majority.


\begin{table}[!t]
\centering
\caption{Number of Ranked Players from 2008 to 2012}
\label{table:ranked_players}
\begin{tabular}{rrrrrr}
\hline
Metrics & Elias & ESPN & GameRank & Inside-edge & TBE\\
\hline
\hline
2008 sum. & 1282 & 367 & 2582 & 818 & 500\\
batting & 636 & 214 & 1291 & 430 & 224\\
pitching & 646 & 153 & 1291 & 388 & 276\\
\hline
2009 sum. & 1256 & 472 & 2532 & 959 & 483\\
batting & 607 & 322 & 1266 & 482 & 220\\
pitching & 649 & 150 & 1266 & 477 & 263\\
\hline
2010 sum. & 1240 & 475 & 2498 & 1212 & 480\\
batting & 616 & 319 & 1249 & 598 & 214\\
pitching & 624 & 156 & 1249 & 614 & 266\\
\hline
2011 sum. & 1286 & 471 & 2590 & 1127 & 462\\
batting & 638 & 310 & 1295 & 557 & 202\\
pitching & 648 & 161 & 1295 & 570 & 260\\
\hline
2012 sum. & 1272 & 459 & 2568 & 1131 & 512\\
batting & 628 & 301 & 1284 & 558 & 229\\
pitching & 644 & 158 & 1284 & 573 & 283\\
\hline
Total & 6336 & 2244 & 12770 & 5247 & 2437\\
\hline
\end{tabular}
\end{table}



\begin{figure*}[!t]
\centering
\subfigure[GameRank v.s. Others in 2008]{ 
    \includegraphics[width=0.32\textwidth]{img/compare/combine-2008.eps}
}
\subfigure[GameRank v.s. Others in 2009]{
    \includegraphics[width=0.32\textwidth]{img/compare/combine-2009.eps}
}
\subfigure[GameRank v.s. Others in 2010]{
    \includegraphics[width=0.32\textwidth]{img/compare/combine-2010.eps}
}
\subfigure[GameRank v.s. Others in 2011]{
    \includegraphics[width=0.32\textwidth]{img/compare/combine-2011.eps}
}
\subfigure[GameRank v.s. Others in 2012]{
    \includegraphics[width=0.32\textwidth]{img/compare/combine-2012.eps}
}
\caption{Comparison between GameRank and other rankings}
\label{fig:compare}
\end{figure*}


Result Similarity of GameRank and Other Ratings
====

Based on the GameRank results as well as other rankings from 2008 to
2012, we compare the rankings certain players get in GameRank and other
rankings, to prove that GameRank generates similar results to other
methods.

Specifically, when we compare GameRank and another ranking $X$, we
normalize their rankings by selecting the players, who is both ranked in
GameRank and $X$. (Actually, players who have $X$ ratings are a
subset of those who have GameRank values)  Then we separately sort all
the selected pitchers and batters by their GameRank as well as $X$, and the results can be compared. 
<!-- 
% $GR rank$; similarly we sort the players by ESPN ratings and get $ESPN
% rank$. Therein, both $GRPitchingRank$ and $ESPNPitchingRank$ have a
% range $[1, 161]$, and both $GRBattingRank$ and $ESPNBattingRank$ are
% ranged in $[1, 310]$. So GR and ESPN ranks can be compared.

% First, we plot the scatter diagram of $GR rank - ESPN rank$, arranged by
% $GR rank$. Figure \ref{fig:bat} for batting, and figure \ref{fig:pitch}
% for pitching. The value is a indicator of a certain player how close the
% two ranks are.
 -->

We then plot Cumulative Distribution Functions (CDFs) to see the
distribution of absolute difference values between players' GameRank and
$X$ rank value, in Figure \ref{fig:compare}. For example, pitcher
Clayton Kershaw ranks No.2 in GameRank in 2012, and ranks No.5 in ESPN
Rank in 2012, so the absolute difference value is 3, in the comparison
of GameRank and ESPN pitcher rankings in 2012.  The horizontal axis
refers to $\frac{|GRrank - OtherRank|}{PlayerNum}$, where $PlayerNum$ is the
total number of pitchers or batters in the relative rankings, which can
be referred to in Table \ref{table:ranked_players}. And the vertical axis
is its cumulative function, i.e. how many players have the difference
below this value. The difference value shows the closeness of the two
ranks.

From the plots we can see that GameRank achieve similar results to these
prestigious rankings. Its results are most close to Inside-Edge (IE)
Rankings, which is in accordance to our analysis above. Besides, the
batter ranks are closer than the pitcher ranks. Take year 2008 as an
example, There are about 60\% batters that has GR and IE ranks with a
difference less than $10\% \times 430 = 43$. Similarly, for over 80\%
players the difference is less than 20\%.

<!-- 
% for 50\% batters, the difference between
% their GR rank and ESPN rank is less than 37; for 80\% batters, the
% difference is less than 85. For 50\% pitchers, the difference is less
% than 40; for 80\% pitchers, the difference is less than 81.  A smaller
% difference demonstrates a better similarity of GR rank and ESPN rank.
% As the range of pitching rank is $[1, 161]$ while the range of batting
% rank is $[1, 310]$, it comes out that the GR ranks are more close to
% ESPN ranks in terms of batting than pitching.
 -->

<!--

Using GameRank and Other Ratings to Predict Winning
====

Secondly, we want to prove that GameRank algorithm is in some way more
persuasive than ESPN Ratings, in an experimental approach. As ranking
the players is quite a subjective procedure, there is no definite
criteria to judge which ranking method is better. However, we come up
with a intuitional assumption: players with better rankings should have
higher probability to win in games.


 % With this assumption, we plot two figures visualizing the frequency for
% pitchers at different rank levels to win over batters at different rank
% levels.  Figure \ref{fig:grc} for GR ranks, and figure \ref{fig:esc} for
% ESPN ranks. In these figures, the horizontal axis refers to batters, and
% the vertical axis refers to pitchers at different levels in the
% according ranking algorithm. The maps are cut into grids for every 10
% pitchers and every 20 batters, and the color of grids refers to average
% frequency for pitchers at specific rank levels to win over batters at
% specific rank levels. The redder, the higher frequency for pitchers to
% win. In specific, for each grid with the left-bottom corner at point
% $(x, y)$, the color of that grid refers to the average frequency for
% pitchers with rank in $(10\times(y-1), 10\times(y)]$ to win batters with
% rank in $(20\times(x-1), 20\times(x)]$.
 

Based on the assumption, the figures show that GR ranks are better than
ESPN ranks in terms of batters: When x-axis is growing which means
pitchers meets "weaker" batters, the frequency for pitchers to win
gets more obviously higher in GR ranks than in ESPN ranks. However, the
GR ranks for pitchers do not seem to have good patterns. Probably we can
say that we achieve better rankings for batters using GameRank, but for
pitchers it is still hard to make such a conclusion.

According to the above comparison, we find that GameRank algorithm is
quite effective in the following ways: (a) it achieves at least similar
results with ESPN rankings, and it is even better in terms of batting
rankings if we set the criteria as wining frequency. (b) What is more,
it is such a simple model that only uses win-lose relationships between
batters and pitchers in games, featuring a perspective of networks. (c)
At last, it can give rankings to all the players as long as they are in
the network, while ESPN Ratings only have a small rated set of 161
pitchers and 310 batters.

GameRank can be made more precise if we dig into the edge weights: how
much is the weight for Home Runs, Sacrifice Flys, and Walks? What if we
consider more complicated and various situations in baseball games? By
customizing weights of different kind of edges, we can easily extend
this method, and make it more powerful at ranking baseball players.

-->