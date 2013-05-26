
\chapter{GameRank在棒球中的应用}
\label{chap:applic}

在本章中，我们使用MLB的数据建立了棒球网络，并应用GameRank在网络上进行了排名。

美国职业棒球大联盟 (MLB)\cite{mlb} 是世界范围内每年最流行的棒球赛事，
在全球有超过70,000,000 名爱好者。 
我们的数据解析自 Retrosheet.org\cite{retrosheet}，该网站维护了从1921年到2012年MLB比赛中，每个局面的数据集。
具体地， Retrosheet仅缺失了如下年份的数据：
1923--1926年，
1928--1930年，
1932--1944年。
从数据集中，我们由每一个局面解析出球员之间的竞争关系，计算了打击员和投手的GameRank值。

计算棒球网络中的 GameRank
====

在棒球比赛中，我们定义了打击员和投手两个角色，
基于算法\ref{alg:gamerank} 计算了打击能力 $GRBatting$ 和 投球能力$GRPitching$，
根据每个球员的这两个值，我们生成了每年打击员和投手的排名。

棒球网络中共有两种类型的边：投球边是投手到打击员的边，表示这次竞争中投手取胜；打击边是打击员到投手的边，表示打击员取胜。为了让我们的排名更加准确，我们基于部分专业知识，为不同类型的边赋予了不同的权值。这些边的权值表示了这些边对于评估球员的重要程度，或这个局面的精彩程度。根据我们的算法，如果一条边拥有更高的边权，他在GameRank的计算中就会有更多的贡献。

在真实的棒球比赛中，局面不只是简单的胜负关系，而是包含一垒打、本垒打、牺牲打、保送等等。在表 \ref{table:weight}中，我们描述了我们如何将不同的权值赋予不同的局面。
例如，我们假设安打的“价值”与打击员上的垒数（垒打数，一垒打为1，二垒打为2，等等）成正比，于是我们令其权值等于垒打数，即1、2、3、4。
其他类型的打击边，如牺牲打和保送，被赋予权值0.5。
不同类型的边有不同的权值，因为我们认为当打击员 $i$ 面对投手 $j$，一个本垒打比起一垒打对评估$i$的打击能力应该有更大的贡献。

\begin{table}[!t]
\centering
\caption{不同局面下边的权值分配}
\label{table:weight}
\begin{tabular}{rrr}
\hline
边的类型 & 局面类型 & 权值 \\
\hline
打击边 & 一垒打 & 1\\
打击边 & 二垒打 & 2\\
打击边 & 三垒打 & 3\\
打击边 & 本垒打 & 4\\
打击边 & 牺牲打 & 0.5\\
打击边 & 保送 & 0.5\\
打击边 & 其他情况 & 0.5\\
投球边 & 所有情况 & 1\\

\hline
\end{tabular}
\end{table}

这些权值可以被自由地调整，并会获得不同的排名结果。我们选择了最简单的权值，来证明这个模型是有效、可提升的。如果能够根据更多的专业棒球知识，合理地调整这些权值，我们的算法将会更加准确。

计算结果
====

作为棒球网络排名的结果，我们在表\ref{table:topbat}中列出了近五年内的“十大打击员”，在表 \ref{table:toppit} 中列出了“十大投手”。 
这些名列前茅的球员，也符合人们对年度明星球员的直觉。
并且，这些排名结果与一些现行的著名排名结果相近，这将会在下一章节中进行分析。

\small
\begin{table*}[!t]
\centering
\caption{Top Batters in recent 5 years}
\label{table:topbat}
\begin{tabular}{rccccc}
\hline
Rank & 2008 & 2009 & 2010 & 2011 & 2012\\
\hline
1 & David Wright & Prince Fielder & Carlos Gonzalez & Matt Kemp & Ryan Braun\\
2 & Chase Utley & Ryan Braun & Albert Pujols & Prince Fielder & Chase Headley\\
3 & Albert Pujols & Ryan Howard & Joey Votto & Justin Upton & Andrew Mc Cutchen\\
4 & Carlos Beltran & Albert Pujols & Matt Holliday & Hunter Pence & Aramis Ramirez\\
5 & Carlos Delgado & Adrian Gonzalez & David Wright & Joey Votto & Miguel Cabrera\\
6 & Ryan Howard & Mark Reynolds & Dan Uggla & Ryan Braun & Aaron Hill\\
7 & Lance Berkman & Derrek Lee & Ryan Braun & Albert Pujols & Buster Posey\\
8 & Adrian Gonzalez & Chase Utley & Kelly Johnson & Troy Tulowitzki & Adam La Roche\\
9 & Matt Holliday & Andre Ethier & Adrian Gonzalez & Adrian Gonzalez & Martin Prado\\
10 & Ryan Braun & Ryan Zimmerman & Jayson Werth & Jacoby Ellsbury & David Wright\\
\hline
\end{tabular}
\end{table*}

\small
\begin{table*}[!t]
\centering
\caption{Top Pitchers in recent 5 years}
\label{table:toppit}
\begin{tabular}{rccccc}
\hline
Rank & 2008 & 2009 & 2010 & 2011 & 2012\\
\hline
1 & Dan Haren & Adam Wainwright & Roy Halladay & Cliff Lee & R A Dickey\\
2 & Cole Hamels & Tim Lincecum & Chris Carpenter & Matt Cain & Clayton Kershaw\\
3 & Johan Santana & Ubaldo Jimenez & Adam Wainwright & Clayton Kershaw & Johnny Cueto\\
4 & Brandon Webb & Zach Duke & Matt Cain & Daniel Hudson & Homer Bailey\\
5 & Tim Lincecum & Bronson Arroyo & Cole Hamels & Chris Carpenter & Mat Latos\\
6 & C C Sabathia & Josh Johnson & Dan Haren & Roy Halladay & Cole Hamels\\
7 & Roy Oswalt & Dan Haren & Brett Myers & Tim Lincecum & Ian Kennedy\\
8 & Ryan Dempster & Javier Vazquez & Tim Lincecum & Ian Kennedy & Matt Cain\\
9 & Ted Lilly & Matt Cain & Tim Hudson & Tim Hudson & Wandy Rodriguez\\
10 & Ricky Nolasco & Jason Marquis & Randy Wolf & Randy Wolf & Kyle Lohse\\
\hline
\end{tabular}
\end{table*}
