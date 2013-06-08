\chapter{绪论}
\label{chap:intro}

体育比赛是许多人娱乐生活中不可或缺的部分。
体育比赛的分析，有助于评估球员和球队，预测比赛结果和球员水平，对制定球队策略也有重要影响。
在各种分析中，球员水平的排序可以提供直观、定量的参考，对观众了解球员水平、球队管理球员等都有深远意义。
目前，不同类型的体育比赛，都有各自的球员排名方法。
然而，他们的排名通常基于独立的线性数据，缺乏一种考虑球员之间联系的全局观点，不能反应竞争对手的实力对球员评估的影响。
例如，棒球中“安打率”这一数据仅考虑打击员所有打席中有几个安打，却不考虑打击员面对投手的能力，而实际中，面对越强的投手能打出安打的球员，越是能力出众的球员。
此外，不同类型的竞技比赛之间有许多共通点，但没有一个有力的、统一的球员排名模型，能够利用这些共通点。

我们提出了通用的抽象模型，可以描述所有的竞技体育，以及其他竞技比赛。
在我们的比赛模型中，球员担任一种或多种*角色*，
不同角色的球员之间，存在不同种类的*竞争*关系。
例如，在棒球中，有投手和打击员的竞争，也有守备队员和跑垒员的竞争；
在足球中，有进攻队员和防守队员的竞争，还有守门员和射门者的竞争。

我们以球员作为结点、球员之间的竞争作为边，建立了比赛的网络（图）模型。
在这个网络中，结点可以有多种角色作为结点属性；存在不同类型的边，分别对应不同类型的竞争关系。

在这一网络模型上，我们设计了通用的算法 \emph{GameRank}，来对球员的某种竞争能力进行排名。
算法的直观意义如下：
对于角色$R_A$ 和 $R_B$之间的一种竞争 $C_{AB}$，
如果一个角色为 $R_A$ 的球员能击败更多、更强的的角色为$R_B$的球员，他就变得更强大。
同理，当一个角色为 $R_B$ 的球员击败了更多、更强的角色为$R_A$的球员时，他也变得更强大。
基于这样的假设，我们设计了算法来量化这一竞争中，球员的竞争能力。
<!-- 我们的算法基于我们先前在棒球上的工作\cite{gamerank_baseball}扩展而成。 -->

注意到，球员之间不仅仅有竞争关系，还有队内的支持协助等多种关系。然而，我们的模型中只考虑竞争关系，因为它对于球员竞争水平的排序有着最直接的参考价值。


我们应用这一方法，对实际的棒球比赛进行了排名，评估球员的打击、投球能力。
为了评估算法，我们将GameRank的结果与其他现有排名方法进行了比较，
<!-- add -->
说明我们的方法不仅能得到与现有权威排名相似的结果，
而且我们的排名结果更加有序，更满足“高位选手更难战胜”的直觉。
接着我们进行了现实棒球比赛网络的分析，获得了许多有趣的发现。
具体来说，我们解析了美国职业棒球大联盟(MLB)\cite{mlb} 的数据。
MLB是世界上最流行的棒球赛事，在全球有着超过70,000,000 的爱好者。
我们的数据解析自 Retrosheet.org\cite{retrosheet}，这里保存了从 1921 年到 2012 年，完整、详细、具体到每一个局面(play)的MLB比赛数据。
从这个结构化的数据集中，我们提取了每一个局面中的投手、打击员之间的竞争关系。
我们计算了所有年份投手、打击员的GameRank值，并对他们进行了排名。
然后，我们通过将我们生成的排名与业界现有的排名方法进行了比较。
通过比较发现，我们的排名与这些现有排名有比较一致的结果。
 <!-- TODO -->
最后，我们分析了带有排名信息的棒球网络，发现了一些有趣的现象。

<!-- In American football, TODO... -->

<!-- league consisting of American League and National League. It has the
most attendance of any sports league with more than 70,000,000 fans.
Baseball being one of the most popular sports in the States, the
statistics analysis of its games and professional players has always
been of great interest. Among researchers, previous works are mainly
focusing on analyzing baseball videos\cite{baseball1, baseball2}, and
there are seldom works on ranking players and analysis of baseball
network.
 -->

<!-- While PageRank\cite{pagerank} can be applied for ranking the teams based
on the game results, valuable players can't be accurately tracked,
because players have multiple abilities, such as ability to hit, to
pitch, to run, and to field (catch balls). To better evaluate players,
we've come up with a novel approach, inspired by PageRank and
HITS\cite{HITS}, to iteratively measure the performance of the given
individual. The algorithm aims at measuring the pitching and batting
ability for each player. It assigns each individual GameRank (GR) values
to represent his pitching / batting ability, and use multiple random
walk models to iteratively accumulate the GR value. The results of
GameRank, its evaluation, along with other analysis results, will also
be shown. -->

<!-- TODO -->

本文其余部分结构如下。
第\ref{chap:related}章介绍了体育比赛分析和网络科学的相关工作。
第\ref{chap:alg}章给出了GameRank的详细描述，解释了它的随机行走模型，给出了它的计算方法，并阐述了算法的收敛性质。
第\ref{chap:applic}章展示了GameRank在MLB棒球网络上的应用，给出了一些排名结果。
第\ref{chap:eval}章通过比较GameRank与其他排名方法的结果，评估了GameRank算法的有效性。
第\ref{chap:anal}章给出了我们应用排名结果，在棒球网络上进行的多种数据分析：网络基本属性、网络演化等，并给出了一些有趣的结果。
<!-- TODO ADD previous work -->
第\ref{chap:future}章阐述了未来的研究方向。
第\ref{chap:conc}章对我们的工作做出总结。
