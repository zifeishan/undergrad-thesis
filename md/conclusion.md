\chapter{结论}
\label{chap:conc}

<!-- Conclusion
====
\label{sec:conc} -->

在本文中，我们展示了一个通用的竞技体育网络模型，其中结点为选手，边为选手之间的竞争关系，不同角色的选手之间存在不同的竞争。
在这个网络上，我们设计了GameRank

In this paper we present a generic network model on competitive sports,
with players as nodes and their competitions as links. We model the
network with different competitions between different player roles, and
design *GameRank*, an universal algorithm to rank players by
competitions, with the network perspective. GameRank has an intuition
that "players that defeat strong opponents are strong". It adopts a
random walk model to consider the impact of their components in the
process to evaluate players.

We apply GameRank on baseball to to analyze the complex statistics of
MLB data, constructing competition networks to evaluate players'
pitching and batting abilities. We rank the MLB networks from 1921 to
2012, and evaluate the algorithm by comparing its results to other
famous rankings. It turns out that our model is excellent in the
following aspects: first, we get the similar results with some
prestigious ranks. Second, our method use a simple network model
considering player relationships. Third, our method is capable of
calculating every player's rankings, while others cannot give a score to
each player.

We then analyze baseball networks based on results of GameRank. We find
that the nodes and links in baseball networks have been increasing, but
the density has been decreasing. We find that according to wining-rate
analysis, GameRank is not better ordered than other rankings, but it
supports the fact that we consider player relationships rather than mere
statistics. We further find that most players only appear on Top-10 list
once, but there are 10 players who have achieved Top-10 more than 10
times. In addition, few players who started to play between
1968 to 1983 have ever achieved a Top-10.

Our contribution lies in following aspects: (1) we propose a  novel
abstraction of universal competitions in games; (2) we give an accurate
player-ranking approach considering competition relationships among
players, which may impact sport-game analysis and team management; (3)
we conduct analysis of large-scale sports data with our network model
and ranking algorithm.
