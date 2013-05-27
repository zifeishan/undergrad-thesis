\chapter{棒球网络分析}
\label{chap:anal}

<!-- Analysis on Baseball Networks
====
\label{sec:anal}
 -->

在这一章节中，我们进行了一些棒球网络的分析，将这些网络的基本信息与GameRank的排名结果结合起来，发现了一些有趣的现象。


<!-- TODO aggregate previous work -->
在我们之前的工作\cite{gamerank_baseball}中，我们发现，在棒球网络中， (1) 球员的水平在逐年接近，(2) 关于投手的打击能力，越好的投手，打击能力越好。

在本文中，我们发现了更多结果：

#. 从1921年到2012年，棒球网络的结点数和边数在上升，但网络密度在下降。 
#. 大部分球员在前十榜中只出现过一次，但历史上有10名球员上榜了超过10次。
#. 1968--1983 年间出道的球员中，上过前十榜的球员异常地少。


网络基本属性随时间的演化
====


\begin{figure}[!hb]
\centering
\subfigure[结点数随时间的演化]{ 
    \includegraphics[width=0.3\textwidth]{img/node-year.eps}
}
\subfigure[边数随时间的演化]{ 
    \includegraphics[width=0.3\textwidth]{img/link-year.eps}
}
\subfigure[网络密度随时间的演化]{ 
    \includegraphics[width=0.3\textwidth]{img/density-year.eps}
}
\caption{网络基本属性随时间的演化}
\label{fig:networkattr}
\end{figure}

首先，在1921--2012年的棒球网络上，我们分析了结点和边的数目随时间的变化。
网络中的节点数目反映了参加比赛的球员的数量，
边的数目反映了记录中球员之间的竞争数目。
我们还计算了网络的密度：$d = \frac{NumLinks}{NumNodes(NumNodes - 1)}$。
结点、边数目的变化在图\ref{fig:networkattr}中展示。
我们发现结点数和边数都在随时间稳步增长，但是网络密度却在下降。
注意Retrosheet在1947年之前的数据并不完全，所以我们在图\ref{fig:networkattr}中抛弃了这些年的数据，只从1947年开始分析。


球员排名随时间的演化
====


\begin{figure}[!t]
\centering
\includegraphics[width=0.45\textwidth]{img/long-winners-all.eps}
\caption{球员进入前十榜的次数与出道年份的关系}
\label{fig:long_winners}
\end{figure}


我们分析了球员排名随时间的演化。
每个球员在某个年份开始加入MLB进行比赛，我们把这个年份叫做球员的出道年份 (starting year)。 
我们计算了曾经进入过球员榜前10名的投手和打击员，并计算了他们有多少次进入了前10名。
我们把球员取得前10名的次数和他们的出道年份绘制成散点图，
在图 \ref{fig:long_winners}中展示。

从图中我们发现，大部分球员只进入前十榜一次，少部分球员入榜多次。
入榜超过10次的球员共有10名，他们的名字在表
\ref{table:bestplayers} 中列出。
我们发现，他们中有正好一半在1980年之后出道。在这些球员中，只有 Albert Pujols 从2000年之后出道，而且他在2001--2012年这12年之间有10次进入前十榜，这表明这位打击员有着极强而稳定的表现。

另外，我们发现 1968--1983 年之间，存在一个较大的空区，点数明显下降。
这表明在这段时间内出道的选手，很少有人进入过前十榜。
这一反常现象原因仍不明，如果不是Retrosheet的数据问题，则应引起注意。


\begin{table}[!t]
\centering
\caption{进入前十榜次数最多的球员}
\label{table:bestplayers}
\begin{tabular}{llrr}
\hline
姓名 & 位置 & 出道年份 & 入前十榜次数\\
\hline
Tom Glavine & 投手 & 1987 & 10\\
Warren Spahn & 投手 & 1952 & 11\\
Robin Roberts & 投手 & 1952 & 10\\
Greg Maddux & 投手 & 1986 & 15\\
Steve Carlton & 投手 & 1965 & 13\\
Mike Schmidt & 打击员 & 1984 & 12\\
Hank Aaron & 打击员 & 1954 & 12\\
Barry Bonds & 打击员 & 1986 & 11\\
Willie Mays & 打击员 & 1951 & 12\\
Albert Pujols & 打击员 & 2001 & 10\\
\hline
\end{tabular}
\end{table}

