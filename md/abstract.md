
\begin{cabstract}

体育比赛中，如何对球员的能力进行排名，是一个富有价值的研究方向。
然而，这一课题尚未被学术界广泛研究。
各项体育比赛中，大多传统的排名方法只考虑了线性的数据，均未考虑球员之间的关系。
为解决这一问题，在近几年新兴的网络理论的指导之下，
我们提出了竞技体育的通用的抽象模型。
在我们的比赛模型中，球员担任一种或多种角色，
不同角色的球员之间，存在不同种类的竞争关系。
我们以球员作为结点、球员之间的竞争作为边，建立比赛的网络模型。
我们设计了比赛网络中通用的算法 \emph{GameRank}，来对球员的某种竞争能力进行排名。
我们的算法采用了随机行走模型，以考虑球员之间关系对球员排名的影响。
算法的指导思想为：强大的球员能够战胜强大的对手。
我们应用这一方法，对实际的棒球比赛进行了排名，评估球员的打击、投球能力。
为了评估算法，我们将GameRank的结果与其他现有排名方法进行了比较。

这一工作的贡献有三方面：一、创新地提出了通用竞技比赛的网络模型；二、提出了更准确的球员排名的算法；三、进行了大规模棒球数据的网络分析和排名，发现了诸多规律和现象。


\end{cabstract}


\begin{eabstract}

Ranking players is a valuable topic in sports analysis, but it is not
well-studied in academia. Without the help of network science,
traditional rankings usually lack a global perspective that considers
relationships between players. To solve this problem, we initiate a
universal abstraction for sports and other competitive games. In our
model of games, players have one or multiple roles, and there can be
different types of competitions between different player roles. We model
the network of games with players as nodes and competitions as links. We
design universal algorithms in these networks named \emph{GameRank}, to rank
players by their ability to achieve certain competitions. Our algorithm
adopts a random walk model to consider the global impact of
relationships among players in the player-evaluation process. The
intuition of our algorithm is: players that defeat strong opponents are
strong. We apply our approach to rank players in real baseball games. We
evaluate our algorithm by comparing our rankings with existing ones. We
further conduct measurements to discover knowledge in specific sports
games with ranking information, and find some interesting results. Our
contribution lies in three aspects: (1) the novel abstraction of
universal competitions in games, (2) the accurate player-ranking
approach which may impact sport-game analysis and team management, and
(3) the analysis of large-scale sports data with our network model and
ranking algorithm.

\end{eabstract}

