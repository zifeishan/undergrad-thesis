\chapter{算法评估}
\label{chap:eval}

<!-- Evaluation
====
\label{sec:eval}
 -->

为了评估GameRank的性能和准确度，我们进行了一系列实验。
在本章中，我们通过比较GameRank的排名结果和一些现有的著名排名，对GameRank进行了评估。
这些现有的排名方法包括 ESPN Ratings\cite{espn}， Elias
Ratings， Inside Edge Rating， 以及 The Baseball Encyclopedia (TBE)Rating。这些排名都在 \cite{ratings} 中有所介绍。

我们从网页数据\cite{ranking_data} 中，
爬取了从2008年到2013年，这四种排名方法的排名结果。
我们在Retrosheet\cite{retrosheet}中没有play-by-play的数据，因此我们只进行了从2008年到2012年的数据的比较。


各排名方法介绍
====

在 ESPN Ratings中，打击员、先发投手和中继投手，被分到不同的排名组中。
在每个组里，通过计算各项指标的加权平均值，来得到一个一维的分数，来衡量球员在排名组中的水平。
例如，打击员的 ESPN rating 由一下指标加权计算而来：垒打数、得分数、上垒率、安打率、本垒打数、打点、安打数、偷垒数、队伍胜率、守备位置难度，等等。它包括10个以上的指标，另外两个排名组里也都包含至少5个指标。

类似地，The Baseball Encyclopedia Ratings也是基于各项指标的线性加和，算出一个分数来评价每个选手。

Inside Edge Rating 是与GameRank最相关的：它 将更为细致的每次投球的情况，而不是每个局面的情况计入统计。
每次投球被赋予一个分数，在这次投球中，打击员和投手中的竞争胜者将会得到一个固定的分数，负者将会失去一个固定的分数。
但这个方法仍然未能考虑球员之间的关系：如果一个投手赢了一个很厉害的打击员，和赢了一个很弱的打击员会获得一样的分数。
因此这个方法仍然忽略了对手在评估中的作用。

Elias Ratings 通过模拟比赛中，待评估球员是否参与这次比赛，对这次比赛胜率的影响。它考虑了各种比赛情境和场地环境，大规模地运行一个比赛模拟器，对比赛局面来进行电脑模拟，从而完成对每名球员的评估。

我们认为，所有这些排名都有一定的不足之处：有些排名仅仅通过计算各种指标的加权平均来陪你姑姑球员，也有的使用了更复杂的办法但仍然忽略了对手的实力对于评估的影响。
这些指标都无法在评估中体现球员之间的关系。

更严重的是，许多球员在这些排名中无法被评估，因为很多人通过这个计算方法算不出得分。
我们的GameRank 算法就可以通过比赛数据，对所有球员进行排序。
在表 \ref{table:ranked_players}中，
我们展示了各种方法能够排名的投手和打击员的数目。
我们注意到 GameRank 可以衡量所有球员投球和打击的能力，
但并非所有球员都既是打击员又是投手。
大部分打击员不会做投手，也有一部分投手不会打击。这些人都被排在相应榜单的最后位置。
<!-- TODO -->


跟其他方法相比，
我们的方法更加简单、自然，可以考虑对手的实力对评估的影响，
并覆盖了更多的球员。


\begin{table}[!t]
\centering
\caption{从 2008 年到 2012年的被排名球员数目}
\label{table:ranked_players}
\begin{tabular}{rrrrrr}
\hline
Metrics & Elias & ESPN & GameRank & Inside-edge & TBE\\
\hline
\hline
2008 sum. & 1282 & 367 & 2582 & 818 & 500\\
打击能力 & 636 & 214 & 1291 & 430 & 224\\
投球能力 & 646 & 153 & 1291 & 388 & 276\\
\hline
2009 sum. & 1256 & 472 & 2532 & 959 & 483\\
打击能力 & 607 & 322 & 1266 & 482 & 220\\
投球能力 & 649 & 150 & 1266 & 477 & 263\\
\hline
2010 sum. & 1240 & 475 & 2498 & 1212 & 480\\
打击能力 & 616 & 319 & 1249 & 598 & 214\\
投球能力 & 624 & 156 & 1249 & 614 & 266\\
\hline
2011 sum. & 1286 & 471 & 2590 & 1127 & 462\\
打击能力 & 638 & 310 & 1295 & 557 & 202\\
投球能力 & 648 & 161 & 1295 & 570 & 260\\
\hline
2012 sum. & 1272 & 459 & 2568 & 1131 & 512\\
打击能力 & 628 & 301 & 1284 & 558 & 229\\
投球能力 & 644 & 158 & 1284 & 573 & 283\\
\hline
汇总 & 6336 & 2244 & 12770 & 5247 & 2437\\
\hline
\end{tabular}
\end{table}




GameRank与其他排名的结果相似性
====


\begin{figure*}[!t]
\centering
\subfigure[GameRank与其他排名的对比：2008年]{ 
    \includegraphics[width=0.45\textwidth]{img/compare/combine-2008.eps}
}
\subfigure[GameRank与其他排名的对比：2009年]{
    \includegraphics[width=0.45\textwidth]{img/compare/combine-2009.eps}
}
\subfigure[GameRank与其他排名的对比：2010年]{
    \includegraphics[width=0.3\textwidth]{img/compare/combine-2010.eps}
}
\subfigure[GameRank与其他排名的对比：2011年]{
    \includegraphics[width=0.3\textwidth]{img/compare/combine-2011.eps}
}
\subfigure[GameRank与其他排名的对比：2012年]{
    \includegraphics[width=0.3\textwidth]{img/compare/combine-2012.eps}
}
\caption{GameRank与其他排名的对比CDF}
\label{fig:compare}
\end{figure*}


基于从2008年到2012年GameRank的结果以及其他排名的结果，
我们比较了同一球员在GameRank和其他排名方法中得到的排名值，
发现GameRank与其他排名的结果比较相似。

具体地，当我们比较 GameRank 和另一个排名方法 $X$的结果时，
我们先对他们的结果进行归一化：
我们选取在两个排名中都得到排名的球员（$X$排名的球员集合为GameRank排名的球员的子集），投手和打击员分开，
然后分别对这些选定的投手和打击员进行排序，得到新的集合中，GameRank和$X$分别的排名值。这样，每一球员的两个排名值就有相同的分母，可以进行比较。
例如，参考表\ref{table:ranked_players}，比较2008年的ESPN和GameRank时，我们抽出214个打击员和153个投手进行排名的归一化；归一化后，ESPN和GameRank的打击排名都在区间$[1,214]$内，投手排名都在区间$[1,153]$内。

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

之后，我们绘制了累积分布函数图 （CDF）， 
来观察球员的GameRank和其他排名之间的绝对差，见图表\ref{fig:compare}。
例如，2012年， 投手 Clayton Kershaw 在GameRank中排名第2位，在ESPN中排名第5位，
则绝对差为3，体现在2012年GameRank和ESPN的比较中。
图表\ref{fig:compare}中，每条曲线是GameRank和一种排名的比较。
横轴为球员在两种排名中的“排名比例”的差值的绝对值，在$(0,1]$之间，其值为 $\frac{|GRrank - OtherRank|}{PlayerNum}$, 其中 $PlayerNum$ 是
相关的排名中总的投手或打击员的数目，与表\ref{table:ranked_players}中相同。
纵轴为累积函数， 即有多大比例球员的这一值（两种排名绝对差所占球员比例），在横轴对应的数目以下。

从这些图表中，我们可以看到GameRank (GR) 与其他几个著名的排名有着类似的结果。
跟GameRank最相似的是 Inside-Edge (IE) 排名，
这与我们上面的分析相符。
另外，GameRank与其他排名相比，打击员的排名比起投手的排名更加接近。
以2008年为例，有大约 60\% 的打击员 GR 和 IE 排名的差值小于 $10\% \times 430 = 43$；类似地，有超过 80\% 的打击员这一差值小于 20\%。
而比较投手的排名，只有大约 40\% 的投手 GR 和 IE 排名的差值小于 $10\% \times 388 = 38.8$；类似地，只有大约 60\% 的投手这一差值小于20\%。


<!--TODO add random!!!-->

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

胜率有序性分析
====

作为一个更有力的验证方法，
我们希望研究，在不同排名方法中，是否高排名的球员能够打败低排名的对手。
已知网络中每对选手之间的胜率，我们通过在不同排名中比较选手胜率与排名的关系，刻画这一排名的"胜率无序度"。

具体地，当我们比较GameRank和排名方法 $X$ 时, 
我们选取在两个排名方法中都被排名的投手$RankedPitchers$，
将他们分别按排名排序，
得到两个排序后的数组 $Pit_{GR}$ 和 $Pit_{X}$。
对年度的每个打击员 $b$ ，我们选取所有
$b$ 面对一个$RankedPitchers$中投手$p$的局面，
计算出当年$b$对$p$的胜率
$win(b,p)$，这是一个 $[0,1]$之间的小数。
我们将所有 $win(b,p)$ 按照 $p$ 在 $Pit_{GR}$ 和 $Pit_{X}$ 中出现的顺序摆放，得到新的数组 $win_{GR}$ 和 $win_{X}$。
例如： 假如$win_{GR} =
[0.1,0.2,0.3,0.4...]$，则它意味着 $b$ 面对第一名的投手有 $10\%$ 的胜率，面对 第二名的投手有 $20\%$ 的胜率，等等。

理想情况下，如果所有打者都能对低排名投手取得更高的胜率，那这个投手排名是最"有序"的。
如何量化排名的有序度呢？我们对 $win_{GR}$ 和 $win_{X}$ 中的*逆序对*进行加权计数。
假设一般地，对于打击员来说，比起高排名投手，低排名投手是更容易战胜的，则逆序对个数可以代表投手排序的无序程度。
逆序对的*加权计数*指，并非统计逆序对个数，而是统计每个逆序对中的胜率差值之和。
例如，如果一个打击员对排名第一的投手胜率为0.5，排名第二的投手胜率为0.1，则这个逆序对的权为$0.5-0.1=0.4$；逆序对中两个胜率相差越悬殊，我们认为这是越大的反常现象，因此权值越高。

为了将方法进行正规化，假设 $IP_{GR}$ 是
$win_{GR}$ 中逆序对差值之和，则我们研究 $IP_{GR}$ 除以数组中最大可能逆序对个数$C^2_{N}$ 的比例：
$R_{GR} = IP_{GR} / C^2_{N}$，其中 $N$ 是数组中的投手数目，这样就消除了结点数目带来的效应。
$R_{GR}$ 就是对于这一名打击员$b$来说，GameRank中投手排名的"无序度"。
整体的投手排名无序度，则为所有打击员的$R_{GR}$相加。
基于以上方法，我们也可以测量打击员的排名无序度。

表 \ref{table:inversion} 展示了其他排名方法与GameRank "无序度" 的不同。 具体地，表中每个元素为 $R_{other} - R_{GR}$。 
绝大部分元素为正数，这说明GameRank比起其他排名更加 "有序"。
这一方法验证了如下结论：
GameRank所得到的排名，比起其他四种排名更能满足如下假设：

#. 一般地，对于投手来说，排名越高的打击员越难战胜。
#. 一般地，对于打击员来说，排名越高的投手越难战胜。

因此我们认为，GameRank比起其他四种排名方法，都有更好的效果。

<!-- 为什么呢？实际上"无序度"的假设并不适合我们的真实情况：
例如在投手排名的无序度测量中，
如果假设每名打击员比起高排名投手都更容易战胜低排名投手，
就相当于假设了排名越高的投手平均战胜的打击员越多。
这个假设并未考虑打击员的水平：
我们不能通过一个球员对所有对手的平均胜率来评判球员，
实际上战胜越强对手的球员越强。 
比起GameRank，其他排名对平均数据进行线性加和，理应获得更低的"无序度"，
但它们不能体现对手强弱带来的影响。
总之， GameRank具有更高的"无序度" 这一点并没有说明它效果不好，反而支持了它能够考虑球员关系、反映对手实力这一点。
 -->

\begin{table}[!t]
\centering
\caption{其他排名方法比起GameRank的无序度}
\label{table:inversion}
\begin{tabular}{rrrrrrrr}
\hline
年份 & 类型 & Elias & ESPN & IE & TBE\\
\hline
2008 & 打击排名 & 0.0008 & 0.0006 & 0.0002 & 0.0008 \\
 & 投球排名 & 0.0013 & 0.0023 & 0.0009 & 0.0013 \\
2009 & 打击排名 & 0.0004 & 0.0006 & 0.0000 & 0.0007 \\
 & 投球排名 & 0.0013 & 0.0025 & 0.0007 & 0.0015 \\
2010 & 打击排名 & 0.0006 & 0.0002 & 0.0002 & 0.0008 \\
 & 投球排名 & 0.0015 & 0.0023 & 0.0007 & 0.0013 \\
2011 & 打击排名 & 0.0003 & 0.0006 & $-$0.0001 & 0.0005 \\
 & 投球排名 & 0.0017 & 0.0025 & 0.0010 & 0.0011 \\
2012 & 打击排名 & 0.0005 & 0.0003 & 0.0000 & 0.0002 \\
 & 投球排名 & 0.0016 & 0.0025 & 0.0010 & 0.0017 \\
% 2008 & batting & 0.03\% & $-$0.33\% & $-$0.48\% & 0.58\% \\
% & pitching & $-$5.07\% & $-$5.32\% & $-$4.59\% & $-$4.03\% \\
% 2009 & batting & 0.16\% & 0.49\% & $-$0.43\% & 0.47\%\\
% & pitching & $-$4.91\% & $-$5.87\% & $-$4.40\% & $-$4.74\% \\
% 2010 & batting & $-$0.07\% & 0.23\% & $-$0.52\% & 0.40\%\\
% & pitching & $-$5.66\% & $-$6.89\% & $-$4.80\% & $-$4.42\% \\
% 2011 & batting & $-$0.17\% & 0.73\% & $-$0.46\% & 0.45\%\\
% & pitching & $-$5.63\% & $-$7.40\% & $-$5.82\% & $-$3.51\% \\
% 2012 & batting & 0.06\% & 0.69\% & $-$0.50\% & 0.13\%\\
% & pitching & $-$5.73\% & $-$6.70\% & $-$6.61\% & $-$4.70\% \\
\hline
\end{tabular}
\end{table}


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