// 批注管理页面脚本 - Tailwind版本
document.addEventListener('DOMContentLoaded', function() {
    let annotations = [
        {
            id: 1,
            timestamp: 15,
            type: 'text',
            content: '注意手臂的角度，要保持90度'
        },
        {
            id: 2,
            timestamp: 32,
            type: 'audio',
            content: '语音批注',
            duration: 5
        },
        {
            id: 3,
            timestamp: 68,
            type: 'text',
            content: '脚步要跟上节拍，不要抢拍'
        },
        {
            id: 4,
            timestamp: 105,
            type: 'text',
            content: '转身动作需要更流畅，练习重心转移'
        }
    ];

    let currentFilter = 'all';
    let editingAnnotation = null;

    // 初始化页面
    renderAnnotations();
    initializeEventListeners();

    // 渲染批注列表
    function renderAnnotations() {
        const annotationsList = document.getElementById('annotationsList');
        const emptyState = document.getElementById('emptyState');
        
        // 过滤批注
        const filteredAnnotations = annotations.filter(annotation => {
            if (currentFilter === 'all') return true;
            return annotation.type === currentFilter;
        });

        if (filteredAnnotations.length === 0) {
            annotationsList.classList.add('hidden');
            emptyState.classList.remove('hidden');
            return;
        }

        annotationsList.classList.remove('hidden');
        emptyState.classList.add('hidden');

        // 生成HTML
        annotationsList.innerHTML = filteredAnnotations.map(annotation => {
            return createAnnotationHTML(annotation);
        }).join('');

        // 绑定事件
        bindAnnotationEvents();
    }

    // 创建批注HTML
    function createAnnotationHTML(annotation) {
        const timeStr = formatTime(annotation.timestamp);
        const typeIcon = annotation.type === 'text' ? '📝' : '🎤';
        
        if (annotation.type === 'text') {
            return `
                <div class="bg-white rounded-xl p-4 shadow-sm flex items-center gap-4 annotation-item cursor-pointer hover:bg-gray-50 transition-colors" data-type="text" data-id="${annotation.id}">
                    <div class="bg-gray-100 px-2 py-1 rounded text-xs font-mono text-gray-600 min-w-max">
                        ${timeStr}
                    </div>
                    <div class="flex items-center gap-3 flex-1">
                        <span class="text-lg">${typeIcon}</span>
                        <div class="flex-1">
                            <p class="text-sm text-gray-800">${annotation.content}</p>
                        </div>
                    </div>
                    <div class="flex gap-2">
                        <button class="p-2 rounded-lg hover:bg-blue-50 text-blue-500 transition-colors edit-btn" data-id="${annotation.id}">
                            <span class="text-sm">✏️</span>
                        </button>
                        <button class="p-2 rounded-lg hover:bg-red-50 text-red-500 transition-colors delete-btn" data-id="${annotation.id}">
                            <span class="text-sm">🗑️</span>
                        </button>
                    </div>
                </div>
            `;
        } else {
            return `
                <div class="bg-white rounded-xl p-4 shadow-sm flex items-center gap-4 annotation-item cursor-pointer hover:bg-gray-50 transition-colors" data-type="audio" data-id="${annotation.id}">
                    <div class="bg-gray-100 px-2 py-1 rounded text-xs font-mono text-gray-600 min-w-max">
                        ${timeStr}
                    </div>
                    <div class="flex items-center gap-3 flex-1">
                        <span class="text-lg">${typeIcon}</span>
                        <div class="flex items-center gap-2 flex-1">
                            <button class="p-1 rounded hover:bg-gray-100 transition-colors play-audio-btn" data-id="${annotation.id}">
                                <span class="text-sm">▶️</span>
                            </button>
                            <span class="text-xs text-gray-500">0:0${annotation.duration || 5}</span>
                        </div>
                    </div>
                    <div class="flex gap-2">
                        <button class="p-2 rounded-lg hover:bg-blue-50 text-blue-500 transition-colors edit-btn" data-id="${annotation.id}">
                            <span class="text-sm">✏️</span>
                        </button>
                        <button class="p-2 rounded-lg hover:bg-red-50 text-red-500 transition-colors delete-btn" data-id="${annotation.id}">
                            <span class="text-sm">🗑️</span>
                        </button>
                    </div>
                </div>
            `;
        }
    }

    // 绑定批注事件
    function bindAnnotationEvents() {
        // 编辑按钮
        document.querySelectorAll('.edit-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.stopPropagation();
                const id = parseInt(this.dataset.id);
                editAnnotation(id);
            });
        });

        // 删除按钮
        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.stopPropagation();
                const id = parseInt(this.dataset.id);
                deleteAnnotation(id);
            });
        });

        // 播放音频按钮
        document.querySelectorAll('.play-audio-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.stopPropagation();
                const id = parseInt(this.dataset.id);
                playAudioAnnotation(id);
            });
        });

        // 批注项点击跳转
        document.querySelectorAll('.annotation-item').forEach(item => {
            item.addEventListener('click', function(e) {
                // 如果点击的是按钮，不执行跳转
                if (e.target.closest('.edit-btn') || 
                    e.target.closest('.delete-btn') || 
                    e.target.closest('.play-audio-btn')) {
                    return;
                }
                
                const id = parseInt(this.dataset.id);
                const annotation = annotations.find(a => a.id === id);
                if (annotation) {
                    jumpToTimestamp(annotation.timestamp);
                }
            });
        });
    }

    // 初始化事件监听器
    function initializeEventListeners() {
        // 过滤按钮
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                // 更新按钮状态
                document.querySelectorAll('.filter-btn').forEach(b => {
                    b.classList.remove('bg-blue-500', 'text-white');
                    b.classList.add('bg-gray-100', 'text-gray-700', 'hover:bg-gray-200');
                });
                
                this.classList.remove('bg-gray-100', 'text-gray-700', 'hover:bg-gray-200');
                this.classList.add('bg-blue-500', 'text-white');
                
                currentFilter = this.dataset.filter;
                renderAnnotations();
            });
        });

        // 返回按钮
        document.getElementById('backBtn').addEventListener('click', function() {
            window.location.href = 'compare.html';
        });

        // 导出按钮
        document.getElementById('exportBtn').addEventListener('click', showExportModal);

        // 编辑模态框事件
        document.getElementById('cancelEdit').addEventListener('click', hideEditModal);
        document.getElementById('saveEdit').addEventListener('click', saveEditAnnotation);
        
        // 导出模态框事件
        document.querySelectorAll('.export-option-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const format = this.dataset.format;
                exportAnnotations(format);
            });
        });

        // 模态框关闭按钮
        document.querySelectorAll('.close-btn').forEach(btn => {
            btn.addEventListener('click', hideAllModals);
        });

        // 点击模态框背景关闭
        document.querySelectorAll('[id$="Modal"]').forEach(modal => {
            modal.addEventListener('click', function(e) {
                if (e.target === this) {
                    hideAllModals();
                }
            });
        });
    }

    // 编辑批注
    function editAnnotation(id) {
        const annotation = annotations.find(a => a.id === id);
        if (!annotation) return;

        editingAnnotation = annotation;
        
        document.getElementById('editTime').value = formatTime(annotation.timestamp);
        document.getElementById('editContent').value = annotation.content;
        
        showEditModal();
    }

    // 删除批注
    function deleteAnnotation(id) {
        if (confirm('确定要删除这条批注吗？')) {
            annotations = annotations.filter(a => a.id !== id);
            renderAnnotations();
            showToast('批注已删除');
        }
    }

    // 播放音频批注
    function playAudioAnnotation(id) {
        const btn = document.querySelector(`[data-id="${id}"].play-audio-btn span`);
        if (btn.textContent === '▶️') {
            btn.textContent = '⏸️';
            showToast('播放音频批注');
            
            // 模拟音频播放
            setTimeout(() => {
                btn.textContent = '▶️';
            }, 3000);
        } else {
            btn.textContent = '▶️';
            showToast('停止播放');
        }
    }

    // 跳转到时间点
    function jumpToTimestamp(timestamp) {
        // 存储时间点信息
        localStorage.setItem('jumpToTime', timestamp.toString());
        showToast(`跳转到 ${formatTime(timestamp)}`);
        
        // 延迟跳转到对比页面
        setTimeout(() => {
            window.location.href = 'compare.html';
        }, 1000);
    }

    // 显示编辑模态框
    function showEditModal() {
        document.getElementById('editModal').classList.remove('hidden');
        document.getElementById('editModal').classList.add('flex');
    }

    // 隐藏编辑模态框
    function hideEditModal() {
        document.getElementById('editModal').classList.add('hidden');
        document.getElementById('editModal').classList.remove('flex');
        editingAnnotation = null;
    }

    // 保存编辑的批注
    function saveEditAnnotation() {
        if (!editingAnnotation) return;

        const newContent = document.getElementById('editContent').value.trim();
        if (!newContent) {
            showToast('请输入批注内容');
            return;
        }

        editingAnnotation.content = newContent;
        renderAnnotations();
        hideEditModal();
        showToast('批注已更新');
    }

    // 显示导出模态框
    function showExportModal() {
        document.getElementById('exportModal').classList.remove('hidden');
        document.getElementById('exportModal').classList.add('flex');
    }

    // 隐藏所有模态框
    function hideAllModals() {
        document.querySelectorAll('[id$="Modal"]').forEach(modal => {
            modal.classList.add('hidden');
            modal.classList.remove('flex');
        });
    }

    // 导出批注
    function exportAnnotations(format) {
        const filteredAnnotations = annotations.filter(annotation => {
            if (currentFilter === 'all') return true;
            return annotation.type === currentFilter;
        });

        let exportData = '';
        let filename = '';

        switch (format) {
            case 'txt':
                exportData = generateTextExport(filteredAnnotations);
                filename = 'annotations.txt';
                break;
            case 'json':
                exportData = JSON.stringify(filteredAnnotations, null, 2);
                filename = 'annotations.json';
                break;
            case 'pdf':
                showToast('PDF导出功能开发中...');
                hideAllModals();
                return;
        }

        // 创建下载链接
        const blob = new Blob([exportData], { type: 'text/plain;charset=utf-8' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);

        hideAllModals();
        showToast(`已导出为 ${format.toUpperCase()} 格式`);
    }

    // 生成文本格式导出
    function generateTextExport(annotations) {
        let text = '比舞APP - 批注导出\n';
        text += '='.repeat(30) + '\n\n';
        
        annotations.forEach((annotation, index) => {
            text += `${index + 1}. [${formatTime(annotation.timestamp)}] `;
            text += `${annotation.type === 'text' ? '文字' : '语音'}批注\n`;
            text += `   ${annotation.content}\n\n`;
        });
        
        text += `\n导出时间: ${new Date().toLocaleString()}\n`;
        return text;
    }

    // 格式化时间
    function formatTime(seconds) {
        const mins = Math.floor(seconds / 60);
        const secs = Math.floor(seconds % 60);
        return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
    }

    // 显示提示消息
    function showToast(message) {
        const toast = document.createElement('div');
        toast.className = 'fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-black bg-opacity-80 text-white px-5 py-3 rounded-lg text-sm z-50';
        toast.textContent = message;
        
        document.body.appendChild(toast);
        
        setTimeout(() => {
            if (document.body.contains(toast)) {
                document.body.removeChild(toast);
            }
        }, 2000);
    }
});