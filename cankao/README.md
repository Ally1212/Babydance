# 比舞APP - Tailwind CSS版本

基于Tailwind CSS重新设计的比舞APP移动端页面，实现了所有核心功能的UI界面。

## 🎨 设计特点

### 技术栈
- **HTML5** - 语义化标签
- **Tailwind CSS** - 原子化CSS框架
- **Vanilla JavaScript** - 原生JS实现交互

### 设计风格
- **简洁大方** - 现代化卡片式设计
- **移动优先** - 响应式布局，完美适配移动设备
- **色彩搭配** - 蓝色主色调(blue-500)，避免紫色
- **交互友好** - 丰富的hover效果和过渡动画

## 📱 页面结构

### 1. 首页 (index.html)
- **视频上传区域** - 支持拖拽上传，视觉反馈清晰
- **历史项目列表** - 卡片式展示，点击可快速加载
- **底部导航** - 固定导航栏，当前页面高亮

### 2. 视频对比页面 (compare.html)
- **双视频播放器** - 响应式布局，横屏并排，竖屏堆叠
- **播放控制栏** - 播放/暂停、同步、倍速、循环控制
- **交互式时间轴** - 可拖拽、缩放、添加批注标记
- **循环设置面板** - 滑入式面板，精确设置循环区间
- **批注添加面板** - 支持文字和语音批注

### 3. 批注管理页面 (annotations.html)
- **过滤器** - 按类型筛选批注(全部/文字/语音)
- **批注列表** - 时间轴展示，支持编辑和删除
- **编辑模态框** - 弹窗式编辑界面
- **导出功能** - 支持TXT、JSON、PDF格式导出

## ⚙️ 核心功能实现

### ✅ 已实现功能

1. **视频并排播放对比**
   - 双视频同步播放控制
   - 响应式布局适配

2. **音乐自动对齐**
   - 同步按钮实现视频对齐
   - 预留音频分析接口

3. **片段循环播放**
   - 可视化循环区间设置
   - 精确时间点选择

4. **可交互时间轴**
   - 拖拽播放进度控制
   - 缩放功能(预留接口)
   - 实时进度显示

5. **倍速播放**
   - 支持1×、0.8×、0.6×三种速度
   - 双视频同步变速

6. **时间轴批注功能**
   - 文字和语音批注支持
   - 批注标记可视化
   - 批注管理和导出

### 🎯 交互细节

- **Toast提示** - 操作反馈清晰
- **加载状态** - 按钮禁用状态管理
- **手势支持** - 触摸设备友好
- **键盘导航** - 无障碍访问支持

## 🚀 使用方法

### 直接使用
1. 在浏览器中打开 `index.html`
2. 选择两个视频文件
3. 点击"开始对比"进入对比页面
4. 使用各种控制功能进行视频分析

### 本地开发
```bash
# 克隆项目
git clone <repository-url>

# 进入目录
cd cankao

# 使用本地服务器运行(推荐)
python -m http.server 8000
# 或
npx serve .

# 访问 http://localhost:8000
```

## 📂 文件结构

```
cankao/
├── index.html          # 首页
├── compare.html        # 视频对比页面
├── annotations.html    # 批注管理页面
├── script.js          # 首页脚本
├── compare.js         # 对比页面脚本
├── annotations.js     # 批注管理脚本
└── README.md          # 项目说明
```

## 🎨 Tailwind CSS 类名规范

### 常用组件类
- **卡片**: `bg-white rounded-xl p-4 shadow-sm`
- **按钮**: `px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors`
- **输入框**: `w-full px-3 py-2 border border-gray-300 rounded-lg text-sm`
- **模态框**: `fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50`

### 响应式断点
- **sm**: 640px+
- **md**: 768px+
- **lg**: 1024px+
- **xl**: 1280px+

## 🔧 自定义配置

### 颜色主题
当前使用蓝色主题，如需修改可替换以下类名：
- `bg-blue-500` → `bg-green-500`
- `text-blue-500` → `text-green-500`
- `border-blue-400` → `border-green-400`

### 动画效果
使用Tailwind的transition类实现：
- `transition-colors` - 颜色过渡
- `transition-transform` - 变换过渡
- `duration-300` - 动画时长

## 📱 移动端优化

### 触摸友好
- 按钮最小点击区域44px
- 滑动手势支持
- 防误触设计

### 性能优化
- 图片懒加载
- CSS动画硬件加速
- 事件委托减少内存占用

## 🔮 后续扩展

### 功能扩展
- [ ] PWA支持
- [ ] 离线缓存
- [ ] 手势识别
- [ ] 视频滤镜

### 技术升级
- [ ] TypeScript重构
- [ ] Vue/React组件化
- [ ] 状态管理集成
- [ ] 单元测试覆盖

---

*本项目为比舞APP的前端原型，可直接用于Flutter开发的UI参考*