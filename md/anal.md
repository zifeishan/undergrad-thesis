\chapter{棒球网络分析}
\label{chap:anal}

<!-- Analysis on Baseball Networks
====
\label{sec:anal}
 -->
In this section we show some analysis with the calculated GameRank on baseball networks, and find some
interesting results.

In previous work\cite{gamerank_baseball} we have found in the baseball
network that (1) players are getting closer in their skills than before,
and (2) good pitchers are also better at batting than normal pitchers.

In this work we find more results: (1) the nodes and links in baseball
networks have been increasing, but the density has been decreasing.  (2)
According to wining-rate analysis with an inversion-pair method,
GameRank is not as well ordered as other rankings, but this supports the
fact that we consider player relationships rather than mere statistics.
(3) Most players only appear on Top-10 list once, but there are 10
players who have achieved Top-10 more than 10 times. (4) Abnormally few
players who started to play between 1968 to 1983, have ever achieved a
Top-10 in GameRank.

\begin{figure*}[!t]
\centering
\subfigure[Number of Nodes over Time]{ 
    \includegraphics[width=0.32\textwidth]{img/node-year.eps}
}
\subfigure[Number of Links over Time]{ 
    \includegraphics[width=0.32\textwidth]{img/link-year.eps}
}
\subfigure[Network Density over Time]{ 
    \includegraphics[width=0.32\textwidth]{img/density-year.eps}
}
\caption{Basic Network Attributes over time}
\label{fig:networkattr}
\end{figure*}


Basic Attributes of Networks over Time
====

First, with the baseball networks from 1921 to 2012, we analyze the
number of nodes and links.  The number of nodes indicate the year's
number of players, and the number of links are number of competitions in
the record. The number of nodes over time is shown in Figure
\ref{fig:networkattr}. We see that both nodes and links are increasing
steadily over time, but the density of the network is decreasing. Note
that Retrosheet data before 1947 are not totally complete, so we discard data in these years in the network attributes analysis.



Winning-rate Analysis
====

We want to study whether players with high rankings will always defeat players with low rankings, and try to analyze characteristics of ranking metrics based by comparing the winning rates of players.

Specifically, when we compare GameRank and ranking metric $X$, we pick
the pitchers that are both ranked in GameRank and $X$, sort them
relatively based on those rankings, and get two sorted arrays $Pit_{GR}$
and $Pit_{X}$. For each batter $b$ in the year, we pick all the plays
that $b$ wins or loses a ranked pitcher. We collect the frequency
$win(b,p)$ that $b$ wins a pitcher $p$, which is in $[0,1]$. We arrange
$win(b,p)$ in the order of $p$ appearing in $Pit_{GR}$ and $Pit_{X}$,
and get new arrays $win_{GR}$ and $win_{X}$. For example, if $win_{GR} =
[0.1,0.2,0.3,0.4...]$, it means that $b$ achieves a $10\%$ winning rate
facing the No.1 pitcher, $20\%$ winning frequency facing the No.2
pitcher, etc.

Ideally, if a certain batter always defeat low-rank pitchers more easily
than high-rank pitchers, the ranking is in the best order. How to
quantify whether a ranking is in good order? We count the *inversion
pairs* in $win_{GR}$ and $win_{X}$. The number of inversion pairs
indicate the disorderliness of the pitchers' rankings, based on the
assumption that low-rank pitchers are more easily defeated. We can also
measure the batters' rankings in a similar way.  To normalize the
measure, assume $IP_{GR}$ is the number of inversion pairs of array
$win_{GR}$, then we can study the ratio $R_{GR}$, which is $IP_{GR}$ divided
by the largest possible number of inversion pairs $C^2_{N}$, where $N$
is the number of pitchers in the array. $R$ is a measure of the
disorderliness of pitchers in GameRank.

Table \ref{table:inversion} shows the difference of disorderliness
between other rankings and GameRank. Specifically, each element is
$R_{other} - R_{GR}$. Most elements are less than $0$, indicating that
GameRank is actually more "disordered" than other rankings. Why does
this happen? Actually the assumption of disorderliness is not suitable
for real cases: we cannot judge a player by its winning rate against all
average players; we should consider the impact of opponents. Those other
metrics which linearly sum up the game statistics will achieve a better
average winning rate, but they cannot differentiate players that defeat
strong or weak opponents with a same winning rate. In short, result
shows that GameRank is less "ordered" compared to other metrics, but
this does not say that it is worse. On the contrary, it supports the
fact that GameRank considers relationships among players, rather than
mere statistics.


\begin{table}[!t]
\centering
\caption{Number of Average Inversions in Ranked Lists}
\label{table:inversion}
\begin{tabular}{rrrrrrrr}
\hline
Year & Type & Elias & ESPN & IE & TBE\\
\hline
2008 & batting & 0.03\% & $-$0.33\% & $-$0.48\% & 0.58\% \\
& pitching & $-$5.07\% & $-$5.32\% & $-$4.59\% & $-$4.03\% \\
2009 & batting & 0.16\% & 0.49\% & $-$0.43\% & 0.47\%\\
& pitching & $-$4.91\% & $-$5.87\% & $-$4.40\% & $-$4.74\% \\
2010 & batting & $-$0.07\% & 0.23\% & $-$0.52\% & 0.40\%\\
& pitching & $-$5.66\% & $-$6.89\% & $-$4.80\% & $-$4.42\% \\
2011 & batting & $-$0.17\% & 0.73\% & $-$0.46\% & 0.45\%\\
& pitching & $-$5.63\% & $-$7.40\% & $-$5.82\% & $-$3.51\% \\
2012 & batting & 0.06\% & 0.69\% & $-$0.50\% & 0.13\%\\
& pitching & $-$5.73\% & $-$6.70\% & $-$6.61\% & $-$4.70\% \\
\hline
\end{tabular}
\end{table}


Player-Rank over Time
====

We analyze the players' ranks over time. Each player start to play in
MLB in some year, we call it "starting year". We collect the players who
have achieved Top 10 in GameRank pitching or batting, and count how many
times they have achieved a Top 10. We plot the relationship between the
number of Top-10s they achieved and their starting year to play, in
Figure \ref{fig:long_winners}.

From the figure we note that most players only get Top-10 once; fewer
players get more Top-10s. There are 10 players who got over 10 times to
be ranked Top-10. Their names are shown in Table
\ref{table:bestplayers}. We see that exactly half them starts from years
after 1980. Among these players, only Albert Pujols starts after 2000,
and he has been on Top-10 for 10 times since 2001 to 2012, indicating that he has consistent great performance.

In addition, we note that there is a big gap between 1968 and 1983 in the figure. It indicates that few players have started playing in this time period and have ever achieved a Top-10.

\begin{figure}[!t]
\centering
\includegraphics[width=0.45\textwidth]{img/long-winners-all.eps}
\caption{Player-Rank over Time: Number of Top-10s and Starting-year}
\label{fig:long_winners}
\end{figure}


\begin{table}[!t]
\centering
\caption{Players with most Top-10s}
\label{table:bestplayers}
\begin{tabular}{llrr}
\hline
Name & Position & Starting Year & Times of Top-10\\
\hline
Tom Glavine & pitcher & 1987 & 10\\
Warren Spahn & pitcher & 1952 & 11\\
Robin Roberts & pitcher & 1952 & 10\\
Greg Maddux & pitcher & 1986 & 15\\
Steve Carlton & pitcher & 1965 & 13\\
Mike Schmidt & batter & 1984 & 12\\
Hank Aaron & batter & 1954 & 12\\
Barry Bonds & batter & 1986 & 11\\
Willie Mays & batter & 1951 & 12\\
Albert Pujols & batter & 2001 & 10\\
\hline
\end{tabular}
\end{table}
