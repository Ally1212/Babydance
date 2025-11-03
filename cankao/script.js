// 首页脚本 - Tailwind版本
document.addEventListener('DOMContentLoaded', function() {
    const video1Input = document.getElementById('video1');
    const video2Input = document.getElementById('video2');
    const startCompareBtn = document.getElementById('startCompareBtn');
    const uploadBox1 = document.getElementById('uploadBox1');
    const uploadBox2 = document.getElementById('uploadBox2');
    
    let selectedVideos = {
        video1: null,
        video2: null
    };

    // 视频文件选择处理
    video1Input.addEventListener('change', function(e) {
        if (e.target.files.length > 0) {
            selectedVideos.video1 = e.target.files[0];
            updateUploadBox(uploadBox1, '✅ 已选择', true);
            checkStartButton();
        }
    });

    video2Input.addEventListener('change', function(e) {
        if (e.target.files.length > 0) {
            selectedVideos.video2 = e.target.files[0];
            updateUploadBox(uploadBox2, '✅ 已选择', true);
            checkStartButton();
        }
    });

    // 更新上传框显示
    function updateUploadBox(uploadBox, text, isSelected) {
        const p = uploadBox.querySelector('p');
        p.textContent = text;
        
        if (isSelected) {
            uploadBox.classList.remove('border-gray-300', 'hover:border-blue-400', 'hover:bg-blue-50');
            uploadBox.classList.add('border-green-400', 'bg-green-50');
        }
    }

    // 检查是否可以开始对比
    function checkStartButton() {
        if (selectedVideos.video1 && selectedVideos.video2) {
            startCompareBtn.disabled = false;
            startCompareBtn.classList.remove('bg-gray-300', 'cursor-not-allowed');
            startCompareBtn.classList.add('bg-blue-500', 'hover:bg-blue-600');
        }
    }

    // 开始对比按钮点击
    startCompareBtn.addEventListener('click', function() {
        if (selectedVideos.video1 && selectedVideos.video2) {
            // 存储视频信息到localStorage
            const videoData = {
                video1: {
                    name: selectedVideos.video1.name,
                    url: URL.createObjectURL(selectedVideos.video1)
                },
                video2: {
                    name: selectedVideos.video2.name,
                    url: URL.createObjectURL(selectedVideos.video2)
                }
            };
            
            localStorage.setItem('compareVideos', JSON.stringify(videoData));
            showToast('正在加载视频对比...');
            
            // 跳转到对比页面
            setTimeout(() => {
                window.location.href = 'compare.html';
            }, 500);
        }
    });

    // 历史记录点击
    document.querySelectorAll('[data-project]').forEach(item => {
        item.addEventListener('click', function() {
            const projectId = this.dataset.project;
            showToast('加载历史项目...');
            
            // 模拟加载历史项目
            setTimeout(() => {
                window.location.href = 'compare.html';
            }, 500);
        });
    });

    // 设置按钮点击
    document.getElementById('settingsBtn').addEventListener('click', function() {
        showToast('设置功能开发中...');
    });

    // 工具函数 - 显示提示消息
    function showToast(message) {
        // 创建toast元素
        const toast = document.createElement('div');
        toast.className = 'fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-black bg-opacity-80 text-white px-5 py-3 rounded-lg text-sm z-50';
        toast.textContent = message;
        
        document.body.appendChild(toast);
        
        // 3秒后移除
        setTimeout(() => {
            if (document.body.contains(toast)) {
                document.body.removeChild(toast);
            }
        }, 3000);
    }
});