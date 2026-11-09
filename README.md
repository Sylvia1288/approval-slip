# 想要清单审批 (Want-list Approval)

**主要功能**：写下"想做/不想做"的事，附上理由、花费和收益，等待一会儿（或交给家人朋友投票）再决定是否通过。
**内容介绍**：这是一个单独的 HTML 文件，需要手动连接 Supabase（或其他任何类似工具）以存储数据、实现多端同步。如果需要在不具备“打开html文件功能”的设备上使用（如手机端），则需要将此 HTML 文件上传至 Netlify（或其他任何类似工具）以发布成网页。（详见**使用步骤**，可免费完成）


## 功能

- **单人模式**：提交申请 → 冷静期结束 → 自己审批（必须写理由）→ 公示页查看结果和用时
- **多人模式**：至少 2 位成员（可自定义头像和昵称）；点成员头像切换身份：可以提交自己的申请（支持加急），可以审批别人的申请，但是不能审批自己的申请；到截止时间后根据少数服从多数判断申请是否通过，平票为"未能决定"；若未通过或未能决定可申请二审
- **申请**：想做 / 不想做，事情，理由，会消耗 / 得到的金钱、时间和其他（自由备注）
- **审批**：需要说明理由，多人模式下若审批未截止则可以更改或撤回
- **公示页面**：可筛选查看今天 / 这周 / 过去一个月 / 全部 / 自定义日期（单日或日期段）的申请
- **冷却时间/截止时间**：单人模式使用冷却时间，在冷却时间结束前无法审批；多人模式使用截止时间，又分为正常截止时间和加急后的截止时间，时间截止后才会进行最终判断。无论哪个都可在**设置页**自行更改，但此处更改无法涉及已提交的申请。


## 基础使用步骤

1. 在 [supabase.com](https://supabase.com) 新建一个免费项目。
2. 打开 **SQL Editor** ，把 `schema.sql` 整段粘贴运行。
3. 在 **Integrations → Data API** 和 **Project Settings → API Keys** 里分别复制 **API URL**（也可能叫Project URL）和 **publishable key** ，填进 `index.html` 里标注"只需要改这两行"的位置。
   （只能用 publishable/anon key，不要用 secret/service_role key）
   （API URL 只保留到 .supabase.co 为止）
4. （建议）可以在 Authentication → Sign In / Providers → User Signups 里关闭 Confirm email，个人使用更省事。
5. 双击 `index.html` 打开，用邮箱加密码注册即可（需要联网）。想在手机上用，请看下面的「发布成网页」。


## 发布成网页（可选，如果想要在手机等设备上用）

1. 新建一个**空**文件夹，把填好 API URL 和 publishable key 的 `index.html` 放进去。
   （文件名必须是 `index.html`，否则打开网址会是 404）
2. 浏览器打开 <https://app.netlify.com/drop>，把整个文件夹拖进去，等待后会得到一个 `xxx.netlify.app` 网址。
3. 点页面上的 **Claim** 认领，如有需要注册一个免费账号即可。
4. 在 **Supabase** 的 **Authentication → URL Configuration** 里，把 **Site URL** 改成新得到的 `netlify.app` 网址。
5. 在手机浏览器中打开这个网址并登录即可开始使用（数据会自动同步）。如果需要添加到桌面：
   - iPhone：用 Safari 打开，点分享按钮，选"添加到主屏幕"。
   - 安卓：用 Chrome 打开，点右上角菜单，选"添加到主屏幕"或"安装应用"。
6. **更新网页**： 在 **Netlify** 后台这个站点的 **Deploys** 页，把新版本的文件夹再拖一次即可覆盖旧版本。
7. （建议）如果仅需个人使用，可以在 **Netlify** 的 **Project configuration → General → Visitor access → Project visibility** 里将所有选项设置为私密，以保证只有你的团队成员（大概率就只有你）可以进入网站。
8. （建议）如果公开发布网站，那么任何知道网址的人都能注册账号。可以等需要用的人都注册好账号之后，在 **Supabase** 的 **Authentication → Sign In / Providers → User Signups** 里关闭 **Allow new users to sign up**。

小提示：
- 免费套餐的额度、规则可能会变，请以 Supabase 和 Netlify 官网为准。
- 也可以用 GitHub Pages、Cloudflare Pages 等其他静态托管。（但我没试过x）
- 免费的 Supabase 项目如果一周内几乎没有使用似乎会被暂停，需要登录后台点 Resume 恢复。


## 局限

- 多人模式里所有成员共用同一个登录账号，"不能审批自己的申请"只是页面上的限制，没有校验。它适合互相监督的朋友和家人，不适合需要防作弊的场景。
- 本文档由AI编写，无技术背景的人类润色，无法提供任何担保。


## AI 声明

本项目的代码由 AI（Anthropic 的 Claude 和 OpenAI 的 ChatGPT）根据作者的需求描述和反复调整编写，作者仅提出需求、做设计决定并负责发布。
代码没有经过专业的安全审计，使用风险自负，不提供任何担保。
本文档由 AI 起草、作者润色。


## 许可与声明

MIT License，见 `LICENSE`。
"赛博朋克"主题只是配色和版式上的致敬。与 CD PROJEKT RED 无关，也未获其认可。
