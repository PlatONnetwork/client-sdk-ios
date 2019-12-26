## 交易接口定义
### web3初始化

```
// 传入链的地址，构造web3
let web3: Web3 = Web3(rpcURL: "http://192.168.120.76:6794", chainId: 103)
```



## staking接口

[发起质押](#staking_contract_1)

[修改质押信息](#staking_contract_2)

[增持质押](#staking_contract_3)

[撤销质押](#staking_contract_4)

[发起委托](#staking_contract_5)

[减持/撤销委托](#staking_contract_6)

[查询当前结算周期的验证人队列](#staking_contract_7)

[查询当前共识周期的验证人列表](#staking_contract_8)

[查询所有实时的候选人列表](#staking_contract_9)

[查询当前账户地址所委托的节点的NodeID和质押Id](staking_contract_10)

[查询当前单个委托信息](#staking_contract_11)

[查询当前节点的质押信息](#staking_contract_12)

## 治理接口

[提交文本提案](#submitText)

[提交升级提案](#submitVersion)

[提交参数提案](#submitParam)

[提交取消提案](#submitCancel)

[给提案投票](#vote)

[版本声明](#declareVersion)

[查询提案](#getProposal)

[查询提案结果](#getTallyResult)

[查询提案列表](#listProposal)

[查询生效版本](#getActiveVersion)

[查询节点代码版本](#getProgramVersion)

[查询可治理参数列表](#listParam)

## 举报惩罚接口

 [举报多签](#ReportDuplicateSign)

[查询节点是否有多签过](#CheckDuplicateSign)

## 锁仓计划接口

[创建锁仓计划](#CreateRestrictingPlan)

[获取锁仓信息](#GetRestrictingInfo)



## staking接口

```
// staking接口方法的调用对象为：web3.staking
// example
web.staking.createStaking(...)
```

<a name="staking_contract_1"></a>
<code style="color: purple;"> createStaking() </code>: 发起质押

```
public func createStaking(
        typ: UInt16, // 表示使用账户自由金额还是账户的锁仓金额做质押，0: 自由金额； 1: 锁仓金额
        benifitAddress: String, // 用于接受出块奖励和质押奖励的收益账户
        nodeId: String,// 被质押的节点Id(也叫候选人的节点Id)
        externalId: String,// 外部Id(有长度限制，给第三方拉取节点描述的Id)
        nodeName: String,// 被质押节点的名称(有长度限制，表示该节点的名称)
        website: String,// 节点的第三方主页(有长度限制，表示该节点的主页)
        details: String,// 节点的描述(有长度限制，表示该节点的描述)
        amount: BigUInt,// 质押的von
        sender: String,// 发送账户地址
        privateKey: String,// 发送账户私钥,
        blsPubKey: String, // bls的公钥
        blsProof: String, // bls的证明,通过拉取证明接口获取
        completion: PlatonCommonCompletion?) {}
```



<a name="staking_contract_2"></a>
<code style="color: purple;">editorStaking() </code>: 修改质押信息

```
public func editorStaking(
        benifitAddress: String, //用于接受出块奖励和质押奖励的收益账户
        nodeId: String, //被质押的节点Id(也叫候选人的节点Id)
        externalId: String, //外部Id(有长度限制，给第三方拉取节点描述的Id)
        nodeName: String, //被质押节点的名称(有长度限制，表示该节点的名称)
        website: String, //节点的第三方主页(有长度限制，表示该节点的主页)
        details: String, //节点的描述(有长度限制，表示该节点的描述)
        sender: String, //发送账户地址
        privateKey: String, //发送账户私钥
        completion: PlatonCommonCompletion?) {}
```



<a name="staking_contract_3"></a>
<code style="color: purple;">increseStaking() </code>: 增持质押

```
public func increseStaking(
        nodeId: String, //被质押的节点Id(也叫候选人的节点Id)
        typ: UInt16, //表示使用账户自由金额还是账户的锁仓金额做质押，0: 自由金额； 1: 锁仓金额
        amount: BigUInt, //增持的von
        sender: String, //发送账户地址
        privateKey: String, //发送账户私钥
        completion: PlatonCommonCompletion?) {}
```



<a name="staking_contract_4"></a>
<code style="color: purple;">withdrewStaking() </code>: 撤销质押(一次性发起全部撤销，多次到账)

```
public func withdrewStaking(
        nodeId: String, //被质押的节点的NodeId
        sender: String, //发送账户地址
        privateKey: String, //发送账户私钥
        completion: PlatonCommonCompletion?) {}
```



<a name="staking_contract_5"></a>
<code style="color: purple;">createDelegate() </code>: 发起委托

```
public func createDelegate(
        typ: UInt16, //表示使用账户自由金额还是账户的锁仓金额做委托，0: 自由金额； 1: 锁仓金额
        nodeId: String, //被质押的节点的NodeId
        amount: BigUInt, //委托的金额(按照最小单位算，1LAT = 10**18 von)
        sender: String, //发送账户地址
        privateKey: String, //发送账户私钥
        completion: PlatonCommonCompletion?) {}
```



<a name="staking_contract_6"></a>
<code style="color: purple;">withdrewDelegate() </code>: 减持/撤销委托(全部减持就是撤销)

```
public func withdrewDelegate(
        stakingBlockNum: UInt64, //代表着某个node的某次质押的唯一标示
        nodeId: String, //被质押的节点的NodeId
        amount: BigUInt, //减持委托的金额(按照最小单位算，1LAT = 10**18 von)
        sender: String, //发送账户地址
        privateKey: String, //发送账户私钥
        completion: PlatonCommonCompletion?) {}
```



<a name="staking_contract_7"></a>
<code style="color: purple;">getVerifierList() </code>: 查询当前结算周期的验证人队列

```
public func getVerifierList(
        sender: String, //发送账户地址
        completion: PlatonCommonCompletion?) {}
```

返参： 列表

```
public struct Verifier: Codable {
    var NodeId: String? //被质押的节点Id(也叫候选人的节点Id)
    var StakingAddress: String? //发起质押时使用的账户(后续操作质押信息只能用这个账户，撤销质押时，von会被退回该账户或者该账户的锁仓信息中)
    var BenefitAddress: String? //用于接受出块奖励和质押奖励的收益账户
    var StakingTxIndex: UInt32? //发起质押时的交易索引
    var ProgramVersion: UInt32? //被质押节点的PlatON进程的真实版本号(获取版本号的接口由治理提供)
    var StakingBlockNum: UInt64? //发起质押时的区块高度
    var Shares: Decimal? //当前候选人总共质押加被委托的von数目
    var ExternalId: String? //外部Id(有长度限制，给第三方拉取节点描述的Id)
    var NodeName: String? //被质押节点的名称(有长度限制，表示该节点的名称)
    var Website: String? //节点的第三方主页(有长度限制，表示该节点的主页)
    var Details: String? //节点的描述(有长度限制，表示该节点的描述)
    var ValidatorTerm: UInt32? //验证人的任期(在结算周期的101个验证人快照中永远是0，只有在共识轮的验证人时才会被有值，刚被选出来时也是0，继续留任时则+1)
}
```



<a name="staking_contract_8"></a>
<code style="color: purple;">getValidatorList() </code>: 查询当前共识周期的验证人列表

```
public func getValidatorList(
        sender: String, //发送账户地址
        completion: PlatonCommonCompletion?) {}
```

返参： 列表

```
public struct Validator: Codable {
    var NodeId: String? //被质押的节点Id(也叫候选人的节点Id)
    var StakingAddress: String? //发起质押时使用的账户(后续操作质押信息只能用这个账户，撤销质押时，von会被退回该账户或者该账户的锁仓信息中)
    var BenifitAddress: String? //用于接受出块奖励和质押奖励的收益账户
    var StakingTxIndex: UInt32? //发起质押时的交易索引
    var ProcessVersion: UInt32? //被质押节点的PlatON进程的真实版本号(获取版本号的接口由治理提供)
    var StakingBlockNum: UInt32? //发起质押时的区块高度
    var Shares: Decimal? //当前候选人总共质押加被委托的von数目
    var ExternalId: String? //外部Id(有长度限制，给第三方拉取节点描述的Id)
    var NodeName: String? //被质押节点的名称(有长度限制，表示该节点的名称)
    var Website: String? //节点的第三方主页(有长度限制，表示该节点的主页)
    var Details: String? //节点的描述(有长度限制，表示该节点的描述)
    var ValidatorTerm: UInt32? //验证人的任期(在结算周期的101个验证人快照中永远是0，只有在共识轮的验证人时才会被有值，刚被选出来时也是0，继续留任时则+1)
}
```

<a name="staking_contract_9"></a>
<code style="color: purple;">getCandidateList() </code>: 查询所有实时的候选人列表

```
public func getCandidateList(
        sender: String, //发送账户地址
        completion: PlatonCommonCompletion?) {}
```

返参： 列表

```
struct CandidateInfo: Codable {
    var NodeId: String? //被质押的节点Id(也叫候选人的节点Id)
    var StakingAddress: String? //发起质押时使用的账户(后续操作质押信息只能用这个账户，撤销质押时，von会被退回该账户或者该账户的锁仓信息中)
    var BenifitAddress: String? //用于接受出块奖励和质押奖励的收益账户
    var StakingTxIndex: UInt32? //发起质押时的交易索引
    var ProcessVersion: UInt32? //被质押节点的PlatON进程的真实版本号(获取版本号的接口由治理提供)
    var Status: UInt32? //候选人的状态(状态是根据uint32的32bit来放置的，可同时存在多个状态，值为多个同时存在的状态值相加0: 节点可用 (32个bit全为0)； 1: 节点不可用 (只有最后一bit为1)； 2： 节点出块率低(只有倒数第二bit为1)； 4： 节点的von不足最低质押门槛(只有倒数第三bit为1)； 8：节点被举报双签(只有倒数第四bit为1))
    var StakingEpoch: UInt32? //当前变更质押金额时的结算周期
    var StakingBlockNum: UInt64? //发起质押时的区块高度
    var Shares: Decimal? //当前候选人总共质押加被委托的von数目
    var Released: Decimal? //发起质押账户的自由金额的锁定期质押的von
    var ReleasedHes: Decimal?//发起质押账户的自由金额的犹豫期质押的von
    var RestrictingPlan: Decimal?//发起质押账户的锁仓金额的锁定期质押的von
    var RestrictingPlanHes: Decimal? //发起质押账户的锁仓金额的犹豫期质押的von
    var ExternalId: String? //外部Id(有长度限制，给第三方拉取节点描述的Id)
    var NodeName: String? //被质押节点的名称(有长度限制，表示该节点的名称)
    var Website: String? //节点的第三方主页(有长度限制，表示该节点的主页)
    var Details: String? //节点的描述(有长度限制，表示该节点的描述)
}
```



<a name="staking_contract_10"></a>
<code style="color: purple;">getDelegateListByDelAddr() </code>: 查询当前账户地址所委托的节点的NodeID和质押Id

```
public func getDelegateListByDelAddr(
        sender: String, //发送账户地址
        addr: String, //委托人的账户地址
        completion: PlatonCommonCompletion?) {}
```

返参： 列表

```
public struct RelatedDelegateNode: Codable {
    var Addr: String? //验证人节点的地址
    var NodeId: String? //验证人的节点Id
    var StakingBlockNum: UInt64? //发起质押时的区块高度
}
```



<a name="staking_contract_11"></a>
<code style="color: purple;">getDelegateInfo() </code>: 查询当前单个委托信息

```
public func getDelegateInfo(
        sender: String, //发送账户地址
        stakingBlockNum: UInt64, //发起质押时的区块高度
        delAddr: String, //委托人账户地址
        nodeId: String, //验证人的节点Id
        completion: PlatonCommonCompletion?) {}
```

返参： 列表

```
struct DelegateInfo: Codable {
    var Addr: String? //委托人的账户地址
    var NodeId: String? //验证人的节点Id
    var StakingBlockNum: UInt64? //发起质押时的区块高度
    var DelegateEpoch: UInt32? //最近一次对该候选人发起的委托时的结算周期
    var Released: Decimal? //发起委托账户的自由金额的锁定期委托的von
    var ReleasedHes: Decimal? //发起委托账户的自由金额的犹豫期委托的von
    var RestrictingPlan: Decimal? //发起委托账户的锁仓金额的锁定期委托的von
    var RestrictingPlanHes: Decimal? //发起委托账户的锁仓金额的犹豫期委托的von
    var Reduction: Decimal? //处于撤销计划中的von
}
```



<a name="staking_contract_12"></a>
<code style="color: purple;">getCandidateInfo() </code>: 查询当前节点的质押信息

```
public func getStakingInfo(
        sender: String, //发送账户地址
        nodeId: String, //验证人的节点Id
        completion: PlatonCommonCompletion?) {}
```

返参： 列表

```
struct CandidateInfo: Codable {
    var NodeId: String? //被质押的节点Id(也叫候选人的节点Id)
    var StakingAddress: String? //发起质押时使用的账户(后续操作质押信息只能用这个账户，撤销质押时，von会被退回该账户或者该账户的锁仓信息中)
    var BenifitAddress: String? //用于接受出块奖励和质押奖励的收益账户
    var StakingTxIndex: UInt32? //发起质押时的交易索引
    var ProcessVersion: UInt32? //被质押节点的PlatON进程的真实版本号(获取版本号的接口由治理提供)
    var Status: UInt32? //候选人的状态(状态是根据uint32的32bit来放置的，可同时存在多个状态，值为多个同时存在的状态值相加0: 节点可用 (32个bit全为0)； 1: 节点不可用 (只有最后一bit为1)； 2： 节点出块率低(只有倒数第二bit为1)； 4： 节点的von不足最低质押门槛(只有倒数第三bit为1)； 8：节点被举报双签(只有倒数第四bit为1))
    var StakingEpoch: UInt32? //当前变更质押金额时的结算周期
    var StakingBlockNum: UInt64? //发起质押时的区块高度
    var Shares: Decimal? //当前候选人总共质押加被委托的von数目
    var Released: Decimal? //发起质押账户的自由金额的锁定期质押的von
    var ReleasedHes: Decimal? //发起质押账户的自由金额的犹豫期质押的von
    var RestrictingPlan: Decimal? //发起质押账户的锁仓金额的锁定期质押的von
    var RestrictingPlanHes: Decimal? //发起质押账户的锁仓金额的犹豫期质押的von
    var ExternalId: String? //外部Id(有长度限制，给第三方拉取节点描述的Id)
    var NodeName: String? //被质押节点的名称(有长度限制，表示该节点的名称)
    var Website: String? //节点的第三方主页(有长度限制，表示该节点的主页)
    var Details: String? //节点的描述(有长度限制，表示该节点的描述)
}
```



## 治理接口

```
// 治理接口方法的调用对象为：web3.proposal
// example
web.proposal.submitText(...)
```

<a name="submitText"></a>
<code style="color: purple;">submitText() </code>: 提交文本提案

```
public func submitText(
        verifier: String, // 提交提案的验证人
        pIDID: String, // PIPID
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletion?) {}
```



<a name="submitVersion"></a>
<code style="color: purple;">submitVersion() </code>: 提交升级提案

```
public func submitVersion(
        verifier: String, \\ 提交提案的验证人
        pIDID: String, \\ PIPID
        newVersion: UInt32, \\升级版本
        endVotingBlock: UInt64, \\ 投票共识轮数量。说明：假设提交提案的交易，被打包进块时的共识轮序号时round1，则提案投票截止块高，就是round1 + endVotingRounds这个共识轮的第230个块高（假设一个共识轮出块250，ppos揭榜提前20个块高，250，20都是可配置的 ），其中0 < endVotingRounds <= 4840（约为2周，实际论述根据配置可计算），且为整数）
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletion?)
```



<a name="submitParam"></a>
<code style="color: purple;">submitParam() </code>: 提交参数提案

```
public func submitParam(
        verifier: String, // 提交提案的备选人
        pIDID: String, // PIPID
        module: String, // 参数模块
        name: String, // 参数名称
        newValue: String, // 参数新值
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?)
```



<a name="submitCancel"></a>
<code style="color: purple;">submitCancel() </code>: 提交取消提案

```
public func submitCancel(
        verifier: String, // 提交提案的验证人
        pIDID: String, // 提案URL，长度不超过512
        endVotingRounds: UInt64, // 投票共识轮数量。参考提交升级提案的说明，同时，此接口中此参数的值不能大于对应升级提案中的值
        tobeCanceledProposalID: String, // 待取消的升级提案ID
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletion?)
```



<a name="vote"></a>
<code style="color: purple;">vote() </code>: 给提案投票

```
public func vote(
        verifier: String, //投票验证人
        proposalID: String, //提案ID
        option: VoteOption, //投票选项
        programVersion: UInt32, // 节点代码版本，有rpc的getProgramVersion接口获取
        versionSign: String, // 代码版本签名，有rpc的getProgramVersion接口获取
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletion?) {}


// 投票选项
public enum VoteOption: UInt8 {
    case Yeas = 1 //支持
    case Nays = 2 //反对
    case Abstentions = 3 //弃权
}
```



<a name="declareVersion"></a>
<code style="color: purple;">declareVersion() </code>: 版本声明

```
public func declareVersion(
        activeNode: String, //声明的节点，只能是验证人/候选人
        version: UInt32, //声明的版本，有rpc的getProgramVersion接口获取
        programVersion: UInt32, // 节点代码版本，有rpc的getProgramVersion接口获取
        versionSign: String, // 代码版本签名，有rpc的getProgramVersion接口获取
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletion?) {}
```



<a name="getProposal"></a>
<code style="color: purple;">getProposal() </code>: 查询提案

```
public func getProposal(
        sender: String,
        proposalID: String, //提案ID
        completion: PlatonCommonCompletion?) {}
```

返参：

```
struct Proposal: Codable {
    var ProposalID: String? // 提案ID
    var Proposer: String? // 提案节点ID
    var ProposalType: UInt8? //提案类型， 0x01：文本提案； 0x02：升级提案；0x03参数提案
    var PIPID: UInt64? // 提案PIPID
    var SubmitBlock: UInt64? // 提交提案的块高
    var EndVotingBlock: UInt64? // 提案投票结束的块高，系统根据SubmitBlock
}
```



<a name="getTallyResult"></a>
<code style="color: purple;">getProposalResult() </code>: 查询提案结果

```
public func getProposalResult(
        sender: String,
        proposalID: String,// 提案ID
        completion: PlatonCommonCompletion?) {}
```

返参：

```
struct TallyResult: Codable {
    var proposalID: String? \\ 提案ID
    var yeas: UInt16? \\ 赞成票
    var nays: UInt16? \\ 反对票
    var abstentions: UInt16? \\ 弃权票
    var accuVerifiers: UInt16? \\ 在整个投票期内有投票资格的验证人总数
    var status: UInt8? \\ 状态
    var canceledBy: String \\ 当status=0x06时，记录发起取消的ProposalID
}
```



<a name="listProposal"></a>

<code style="color: purple;">getProposalList() </code>: 查询提案列表

```
public func getProposalList(
        sender: String,
        completion: PlatonCommonCompletion?) {}
```

返参：

```
struct Proposal: Codable {
    var ProposalID: String? // 提案ID
    var Proposer: String? // 提案节点ID
    var ProposalType: UInt8? //提案类型， 0x01：文本提案； 0x02：升级提案；0x03参数提案
    var PIPID: String // 提案PIPID
    var SubmitBlock: UInt64? // 提交提案的块高
    var EndVotingBlock: UInt64? // 提案投票结束的块高
    var EndVotingRounds: UInt64? // 投票持续的共识周期数量
    var ActiveBlock: UInt64? // 提案生效块高，系统根据EndVotingBlock算出
    var NewVersion: UInt? // 升级版本
    var TobeCanceled:String? // 提案要取消的升级提案ID
}
```



<a name="getActiveVersion"></a>

<code style="color: purple;">getActiveVersion() </code>: 查询节点的链生效版本

```
public func getActiveVersion(
        sender: String,
        completion: PlatonCommonCompletion?)
```

返参：

```
String // 版本号的json字符串，如{65536}，表示版本是：1.0.0。
解析时，需要把ver转成4个字节。主版本：第二个字节；小版本：第三个字节，patch版本，第四个字节
```



<a name="getGovernParamValue"></a>

<code style="color: purple;">getGovernParamValue() </code>: 查询当前块高的治理参数值

```
public func getGovernParamValue(
        module: String,
        name: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<String>?>?)
```

返参：

```
参数值的json字符串，如{"32"}。返回的都是字符串，客户端自行转成目标类型
```



<a name="getAccuVerifiersCount"></a>

<code style="color: purple;">getAccuVerifiersCount() </code>: 查询提案的累积可投票人数

```
public func getAccuVerifiersCount(
        proposalID: String,
        blockHash: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<[UInt16]>?>?)
```

返参：

```
是个[]uint16数组
[累积可投票人数, 赞成票数, 反对票数, 弃权票数]
```



<a name="listParam"></a>

<code style="color: purple;">getListParam() </code>: 查询可治理参数列表

```
public func listGovernParam(
        module: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<[Govern]>?>?)
```

返参：

```
是个[Govern]数组
```



## 举报惩罚接口

```
// 举报惩罚接口方法的调用对象为：web3.slash
// example
web.slash.reportDuplicateSign(...)
```

<a name="ReportDuplicateSign"></a>
<code style="color: purple;">ReportDuplicateSign() </code>: 举报双签

```
public func reportDuplicateSign(
        typ: UInt8, // 代表双签类型，1：prepareBlock，2：prepareVote，3：viewChange
        data: String, //证据的json值，格式为RPC接口Evidences的返回值
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletion?)
```



<a name="CheckDuplicateSign"></a>
<code style="color: purple;">CheckDuplicateSign() </code>: 查询节点是否已被举报过多签

```
public func checkDuplicateSign(
        sender: String,
        typ: UInt32, // 代表双签类型 1：prepare，2：viewChange，3：TimestampViewChange
        addr: String, // 举报的节点地址
        blockNumber: UInt64, // 多签的块高
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<String>?>?) {}
```

返参：

```
string类型，举报的交易Hash
```



## 锁仓接口

```
// 锁仓接口接口方法的调用对象为：web3.restricting
// example
web.restricting.createRestrictingPlan(...)
```

<a name="CreateRestrictingPlan"></a>
<code style="color: purple;">CreateRestrictingPlan() </code>: 创建锁仓计划

```
public func createRestrictingPlan(
        account: String, //锁仓释放到账账户
        plans: [RestrictingPlan], // RestrictingPlan 类型的列表
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletion?)
        

public struct RestrictingPlan {
    var epoch: UInt64 //表示结算周期的倍数。与每个结算周期出块数的乘积表示在目标区块高度上释放锁定的资金。Epoch \* 每周期的区块数至少要大于最高不可逆区块高度
    var amount: BigUInt // 表示目标区块上待释放的金额
}
```



<a name="GetRestrictingInfo"></a>
<code style="color: purple;">GetRestrictingInfo() </code>: 获取锁仓信息。

注：本接口支持获取历史数据，请求时可附带块高，默认情况下查询最新块的数据。

```
public func getRestrictingPlanInfo(
        sender: String,
        account: String, //锁仓释放到账账户
        completion: PlatonCommonCompletion?) {}
```

返参：

```
public struct RestrictingInfo: Decodable {
    var balance: Decimal? //锁仓余额
    var debt: Decimal? //symbol为 true，debt 表示欠释放的款项，为 false，debt 表示可抵扣释放的金额
    var symbol: Bool? // debt 的符号
    var info: Bytes //锁仓分录信息，json数组：[{"blockNumber":"","amount":""},...,{"blockNumber":"","amount":""}]。其中：<br/>blockNumber：\*big.Int，释放区块高度<br/>amount：\*big.Int，释放金额
}
```