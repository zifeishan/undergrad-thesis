\chapter{算法介绍}
\label{chap:alg}

<!-- GameRank: Generic Algorithm to Rank Players in Competitions
====
\label{sec:alg}
 -->

目的及动机
====

在竞技体育比赛中，选手可能具有多种能力：如棒球中的打击和投球能力，足球中的进攻和防守能力，篮球中的投篮和阻攻能力，等等。
传统的分析往往独立地评估这些能力，例如：统计棒球中的“安打率”以衡量打击能力，统计足球中的射门数、进球数来衡量进攻能力，以及篮球中的投篮数、得分数、篮板数等。
然而，这些能力不应该进行独立的评估。
例如：棒球中，一个打击员如果安打率为0.3，他可能面对10个强大的投手击出3个安打，也可能面对10个弱投手击出3个安打，而显然前者更加强大。
类似地，在独立的评估中，我们不知道足球队员进球或传球时面对的对手情况，以及篮球队员射门和抢断时的对手信息。
简言之，评估竞技比赛中选手的能力时，需要考虑对手的能力。

为了解决这一问题，我们在竞技体育比赛中建立了网络模型，以对球员之间的竞争关系进行建模。在这一网络模型上，我们提出了一套算法，来根据球员的竞争能力对球员进行排序。算法的基本假设为*强大的球员可以战胜强大的对手*。

在本章节中，我们将定义竞技比赛网络，
定义*GameRank*这一网络指标来评估球员，
解释这一指标的概率意义，
给出计算GameRank的算法，
并给出算法的收敛特性。

<!-- 
% Our assumptions in the baseball network are: (a) a player is good at
% batting if he wins over good pitchers; (b) a player is good at pitching
% if he wins over good batters.

% This model is quite similar to hubs and authorities\cite{hub_auth}, which is the abstraction of Web presented by HITS algorithm: good hubs link to good authorities, and good authorities are linked by good hubs. Although HITS does not perform well in the context of Web, this intuition fits in well in the baseball network. 

% To iteratively calculate each player's ability, a random walk model is
% applied to obtain the stationary distribution of the player's pitching and batting abilities, i.e. GameRank values. One of the strength of the random walk is that it provides a good probabilistic meaning for the algorithm, and fits in well with our assumption. Detailed description of the random walk model is stated in the following subsection.
 -->


竞技比赛网络模型
====

在竞技比赛中，选手作为不同角色，进行相互竞争。
例如，棒球中，投手与打击员进行竞争，守备队员与跑垒员进行竞争；球员在比赛中可以拥有多重角色，如投手在进攻时就变成打击员，打击员击出球之后就变成跑垒员。
足球中，进攻队员与防守队员和守门员进行竞争，进攻队员在防守时会变为防守队员。

通过这些例子，我们总结出竞技比赛网络的通用模型，在这个模型中每名选手有一个或多个角色，选手之间存在竞争。不同角色之间存在不同种类的竞争。竞技比赛网络的定义如下：

\begin{definition}[竞技比赛网络] 
竞技比赛网络由一系列结点和有向边组成。结点和边的定义如下。

\textbf{结点：} 网络中的每个结点 $N_i$ 代表一位选手。

\textbf{结点属性：} 每个结点有一个或多个角色 ($R_A,
R_B, R_C...$) 作为其属性。

\textbf{边：} 每条从结点 $N_i$ 到结点 $N_j$ 的有向边，代表选手$N_i$ 和 $N_j$ 之间的一次竞争，并且$N_i$赢得了这次竞争的胜利。边的权重代表这次竞争的重要性。

\textbf{边的类型：} 有多种类型的边，代表不同类型的竞争。类型 $C_{AB}$ 的边，只能从角色为 $A$ 的结点指向角色为 $B$的结点。

\end{definition}

例如，棒球网络中，考虑投手-打击员的竞争关系，*结点*是球员，*边*是投手和打击员之间的每一次局面(play)。
结点有如下角色（属性）：$R_P$ 代表投手，
$R_B$ 代表打击员。 
有两种类型的边：$C_{BP}$ 代表“打击边”，即打击员战胜投手的边，如一垒打、本垒打、保送等。
$C_{PB}$ 代表“投球边”，即投手战胜打击员的边，如三振出局、封杀出局等。
棒球网络的定义在图 \ref{fig:baseball_types} 中画出。

\begin{figure}[!t]
\centering
% \subfigure[Batting Rank Difference: Scatter Diagram]{
\includegraphics[width=0.8\textwidth]{img/baseball-types.eps}
\caption{Definition of Baseball Networks}
\label{fig:baseball_types}
% }
\end{figure}


GameRank 指标
====

我们定义了 *GameRank* 指标，来根据竞技比赛网络中的选手的竞争，对选手进行排名。

GameRank的两个*假设*如下：

#. 在一种竞争中，如果选手能战胜越多、越强大的对手，该选手就越强大。

#. 不同种类的竞争之间是相互独立的。

例如，在棒球网络中，当评估棒球选手的“投球-打击”这一对竞争能力时，我们忽略球员“跑垒-守备”等其他竞争。
GameRank假设，越强大的打击员可以战胜越多、越强大的投手，反之亦然。

在足球网络中，当评估射门员和守门员的竞争能力时，我们忽略其他防守队员的影响。我们
认为好的射门员可以面对好的守门员有更多进球，反之亦然。当我们评估进攻和防守队员时，我们认为好的进攻队员可以突破好的防守队员，反之亦然。这两种评估提供了不同的角度来分析比赛。

基于这些假设，我们定义GameRank指标如下：

\begin{definition}[无权图中的GameRank]
\label{def:unweighted}

当比赛网络是一张无权图时，我们考虑角色 $R_A$ 和 $R_B$之间的竞争关系：$C_{AB}$边为从$R_A$角色结点指向$R_B$角色结点的边，$C_{BA}$边相反。

$N$ 为网络中的结点数目。 

$InDeg_{AB}(i)$ 为结点 $i$的 $C_{AB}$ 类型边的入度，亦即指向结点$i$的$C_{AB}$边的数目。

$InDeg_{BA}(i)$ 为结点 $i$的 $C_{BA}$ 类型边的入度，亦即指向结点$i$的$C_{BA}$边的数目。

$outlinks_{AB}(i)$ 为从$i$出发的$C_{AB}$边的终点的集合。

$outlinks_{BA}(i)$ 为从$i$出发的$C_{BA}$边的终点的集合。

球员$i$在$C_{AB}$竞争中作为角色$A$获胜的能力为：
\begin{equation}
GR_{AB}(i) = \beta / N + (1 - \beta) \sum_{j \in outlinks_{AB}(i)}{
\frac{GR_{BA}(j)}{InDeg_{AB}(j)}
}
\end{equation}

球员$i$在$C_{BA}$竞争中作为角色$B$获胜的能力为：
\begin{equation}
GR_{BA}(i) = \beta / N + (1 - \beta) \sum_{j \in outlinks_{BA}(i)}{
\frac{GR_{AB}(j)}{InDeg_{BA}(j)}
}
\end{equation}

其中， $\beta$ 是阻尼因子，我们在计算中取与PageRank\cite{pagerank}相同的经验常数 $0.15$。
\end{definition}

在实际情况中，网络的边往往是带权的。边权的大小反映了这次竞争对评估球员的重要性，可以根据竞争效果（如一垒打或本垒打）、竞争时间（时间越近边权越高）等因素取定权值。
为了简化表示，我们假设$i$ 到 $j$ 的同种类的边都被整合为一条边，其种类与整合前相同，权值等于整合前所有边的权值相加。
与带权的PageRank类似，我们可以将GameRank的定义修改如下：

\begin{definition}[带权图中的GameRank]
\label{def:weighted}
当比赛网络是一张带权图时，我们考虑角色 $R_A$ 和 $R_B$之间的竞争关系：$C_{AB}$边为从$R_A$角色结点指向$R_B$角色结点的边，$C_{BA}$边相反。在定义 \ref{def:unweighted}的基础上，

$w_{AB}(i,j)$ 为从结点$i$到结点$j$的$C_{AB}$类型边的权值。

$w_{BA}(i,j)$ 为从结点$i$到结点$j$的$C_{BA}$类型边的权值。

$WInDeg_{AB}(i)$ 为结点 $i$的 $C_{AB}$ 类型边的带权入度，亦即指向结点$i$的$C_{AB}$边的权值之和。

$WInDeg_{BA}(i)$ 为结点 $i$的 $C_{BA}$ 类型边的带权入度，亦即指向结点$i$的$C_{BA}$边的权值之和。

于是我们修改GameRank公式如下：

\begin{equation}
\label{equ:1}
GR_{AB}(i) = \beta / N + (1 - \beta) \sum_{j \in outlinks_{AB}(i)}{
\frac{w_{AB}(i,j)GR_{BA}(j)}{WInDeg_{AB}(j)}
}
\end{equation}

\begin{equation}
\label{equ:2}
GR_{BA}(i) = \beta / N + (1 - \beta) \sum_{j \in outlinks_{BA}(i)}{
\frac{w_{BA}(i,j)GR_{AB}(j)}{WInDeg_{BA}(j)}
}
\end{equation}
\end{definition}

在角色 $A$ 与 $B$的竞争之间， $GR_{AB}$ 指标描述了选手作为角色 $A$ 击败角色 $B$的能力， 同理 $GR_{BA}$ 指标描述了选手作为角色 $B$ 击败角色 $A$的能力。

例如，在棒球中，我们定义角色 $A$ 为打击员，角色 $B$ 为投手，
于是 $GR_{AB}$ 衡量了选手的打击能力，
$GR_{BA}$ 衡量了选手的投球能力。
我们可以对于所有球员计算这两个值，并由此生成选手的打击排名和投球排名。

<!--
% batting and pitching abilities of players. With these values, we can rank the players by batting and pitching abilities separately, thus got \emph{GR batting rank} and \emph{GR pitching rank}.
-->

算法解释：随机行走
====

GameRank 可以被看做在两个网络（对应一种竞争的两种不同边）
之间往返的随机行走模型。
下面的例子直观地解释了棒球网络中，GameRank指标背后的概率意义。
在这个例子中， $A$ 代表打击员， $B$ 代表投手；
$GR_{AB}$ 记作 $GRBatting$，
$GR_{BA}$ 记作 $GRPitching$。

假设一个MLB的球迷，拥有所有的比赛局面数据，每一个局面记录了投手 $i$ 击败打击员 $j$ 或打击员$i$击败投手$j$的情况（即为图 \ref{fig:baseball_types}中定义的一条投球边或一条打击边）。
为了找到年度最佳球员，这名球迷最初随机选取一名打击员 $A$，
然后随机地选取一个局面，在这个局面中，投手$B$战胜了打击员$A$。
之后他又随机选取一个局面，其中打击员 $C$ 战胜了投手 $B$ ……
在这样往复的过程中，经过足够长的时间，他在看一个特定打击员$x$的概率，即
$GRBatting(x)$，
或者他在看一个投手$x$的概率，即 $GRPitching(x)$，代表了 $x$的打击（投球）能力。

如果有一个打击员 $i$ ，网络中没有投手赢过$i$，那么当球迷访问到$i$时，他会随机跳转到网络中任意一个投手，继续观看局面。同理，当访问到一个没有被任何打击员战胜的投手$i$时，他也会跳转到一名随机的打击员继续这一过程。

有时，球迷也会不依序观看下一个局面，而是对当前投手（打击员）$i$感到厌倦，随机跳转到网络中的一个打击员（投手）$j$。这种事件发生的概率为$\beta$，即阻尼因子。

在这个过程中，球员$x$战胜越多、越强大的对手，他就会以越高的概率被访问到，他的GameRank值也就越高。
如果 $x$ 是一个打击员，他战胜了很多有着很高 $GRPitching$ 的投手，那么他的
$GRBatting$ 也会很高；
如果$x$ 是一个投手，战胜了很多 $GRBatting$ 高的打击员，那么他的 $GRPitching$ 也会很高。
这就是GameRank的直观意义，它与我们在棒球网络中“强大球员可以战胜强大对手”的假设是吻合的。

GameRank的计算方法
====

在本节中，我们会具体介绍 GameRank 值是如何通过一个迭代的算法计算出来的。在算法 \ref{alg:gamerank} 中，我们展示了 $GR_{AB}$ 和 $GR_{BA}$ 两个指标的迭代计算方法，应用场景为一个带权的网络，且考虑了“悬挂点”（无入边的点）的处理。
我们使用的变量均在 定义\ref{def:unweighted} 与 定义\ref{def:weighted}中给出。

\begin{algorithm}[!ht]
\label{alg:gamerank}
 \SetAlgoLined
 \KwIn{\
  $N$, $nodes$, $links_{AB}$, $links_{BA}$, $w_{AB}$, $w_{BA}$, $WInDeg_{AB}$, $WInDeg_{BA}$, $\beta$}
 \KwOut{$GR_{AB}$, $GR_{BA}$}
 
 $danglings_{AB} \leftarrow$ nodes without in-links in $links_{AB}$\;
 $danglings_{BA} \leftarrow$ nodes without in-links in $links_{BA}$\;
 $GR_{AB} \leftarrow [1/N, 1/N, ..., 1/N]$\;
 $GR_{BA} \leftarrow [1/N, 1/N, ..., 1/N]$\;
 \Repeat{$\delta_{AB} \rightarrow 0$ {\bf and} $\delta_{BA} \rightarrow 0$} {
  % calc GR_{AB}
  $DanGR_{AB} \leftarrow \sum_{d \in danglings_{AB}}{GR_{BA}(d)/N}$\;
  \For{$i \in nodes$} {
    $tmpGR_{AB}$ = 0\;
    \For{$(i,j) \in links_{AB}$}{
      $tmpGR_{AB} \leftarrow tmpGR_{AB} + \frac{w_{AB}(i,j) \times GR_{BA}(j)}{ WInDeg_{AB}(j)}$\;
    }
    $NewGR_{AB} \leftarrow \beta/n + DanGR_{AB} + tmpGR_{AB}$\;
  }

  % calc GR_{BA}
  $DanGR_{BA} \leftarrow \sum_{d \in danglings_{BA}}{GR_{AB}(d)/N}$\;
  \For{$i \in nodes$} {
    $tmpGR_{BA}$ = 0\;
    \For{$(i,j) \in links_{BA}$}{
      $tmpGR_{BA} \leftarrow tmpGR_{BA} + \frac{w_{BA}(i,j) \times GR_{AB}(j)}{ WInDeg_{BA}(j)}$\;
    }
    $NewGR_{BA} \leftarrow \beta/n + DanGR_{BA} + tmpGR_{BA}$\;
  }
  $\delta_{AB} \leftarrow \max_{i \in nodes}{|NewGR_{AB}(i) - GR_{AB}(i)|}$\;
  $\delta_{BA} \leftarrow \max_{i \in nodes}{|NewGR_{BA}(i) - GR_{BA}(i)|}$\;
  $GR_{AB} \leftarrow NewGR_{AB}$\;
  $GR_{BA} \leftarrow NewGR_{BA}$\;
 }
 \KwRet{$GR_{AB}, GR_{BA}$}
 \caption{计算带权网络的GameRank值}
\end{algorithm}


收敛性质
====

网络中有一些结点没有入边，也即网络中没有对手能战胜他们。这样的结点被称为*悬挂点*(dangling nodes)，在上面一节的算法中有定义。
这些悬挂点的存在会导致网络中GameRank值的不收敛，其中悬挂点会作为吸收态，导致GameRank总值减小。
为了处理这种不收敛性，如果随机行走中遇到了一个悬挂点（吸收态），
行走的下一步将以等概率跳跃到网络中一个随机的点。
我们可以将这个过程看做：对于每一个悬挂点$d$，添加网络中所有节点到$d$的一条边。变的类型与$d$缺失的入边类型相同。
这个过程在算法\ref{alg:gamerank}中有所反映。

与此同时，我们有阻尼因子$\beta$，导致保证在随机行走的每一步，行走者会以$\beta$概率跳转到网络中的任意一个结点，而非沿一条边行走。在阻尼因子和悬挂点处理的共同作用下，网络变为一个强连通图，因此我们可以保证无论初始分布如何，GameRank值都将收敛于一个固定的稳态分布。相关的证明可以参考文献\cite{conv}，在我们的论文
\cite{gamerank_baseball}里也有阐述。

<!-- 
For simple illustration of convergence, we first take a look at the convergence proof of the original PageRank. Let $\pi^T$ be the $1 * n$ PageRank row vector, we can describe the iteration at the $k-th$ step as \begin{equation}
\pi^{(k+1)T} = \pi^{kT}H
\end{equation}
where H is the row-normalized adjacency matrix.

To ensure stochasticity, $H$ should be of non-negative elements and every row in it should sum to one, yet by definition there could be rows summing up to zero. We define stochastic $H’ = H + \frac{ae^T}{n}$, where $a_i = 1$ is a column vector if $\sum^n_{k=1}H_{ik} = 0$ and $a_i = 0$ otherwise, $e$ is the unit column vector.

To guarantee there exists unique stationary distribution vector $\pi^T$, $H’$ should be irreducible, which happens if and only if the corresponding graph is strongly connected\cite{conv}. This is where damping factor $\beta$ comes in. With $0 \le \beta \le 1$ and $E = ee^T/n$, we get irreducible, row-stochastic matrix $H’’ = \beta H’ + (1-\beta ) E$. Then we can rewrite the iteration equation as 
\begin{equation}
\pi^{(k+1)T} = \pi^{kT}H’’
\end{equation}
provided that $\pi$ will converge to the unique stationary distribution.

Back at GameRank, we build and modify the adjacency matrices in accordance to that above. The elements are by definition non-negative and normalized, the dangling nodes are taken care of to make sure each row sums up to one, and $\beta$ make the matrices irreducible. $GRB$ and $GRP$ then, should converge to their corresponding unique stationary distribution.
 -->


GameRank与PageRank的关系
====

PageRank\cite{pagerank} 是网络领域内十分著名的排名算法。我们的 GameRank 算法在几个方面与 PageRank都有相似之处：
他们都是基于网络模型和随机游走；
而且，如果我们把一个结点的不同角色划分为多个不同的结点，网络中只考虑一种角色$A$和$B$之间的竞争关系，那么这个网络就变为一个二部图，在这个图上的GameRank定义就与PageRank等效，因为这个图上的每个结点只能同时拥有一种角色。
在此基础上，一个角色为 $A$的结点的 $PR$ 值，就与划分前的网络中结点的 $GR_{AB}$值相等；角色为$B$的结点的 $PR$ 值，就与就与划分前的网络中结点的 $GR_{BA}$值相等。
因此， GameRank 可以与PageRank 之间映射，可以通过变换网络结构来将GameRank转换到PageRank。

那么，为什么我们不直接用转换后的网络计算选手的 PageRank呢？
我们认为，我们的竞技比赛模型更加自然、应用更加广泛：结点可以拥有多个角色，可以有多种竞争并存。如今我们假设不同的竞争是独立的，但如果他们是互相依赖的，这一网络就无法轻易通过拆分计算有意义的PageRank。我们的网络模型，对于未来的研究分析，应用前景更加广泛。另外，在我们以前还没有系统全面的网络分析模型来分析竞技比赛，因此我们的模型和算法在这一领域内仍然是十分新颖的。
