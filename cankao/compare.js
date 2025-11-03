// 视频对比页面脚本 - Tailwind版本
document.addEventListener('DOMContentLoaded', function() {
    const video1 = document.getElementById('video1');
    const video2 = document.getElementById('video2');
    const playBtn = document.getElementById('playBtn');
    const pauseBtn = document.getElementById('pauseBtn');
    const syncBtn = document.getElementById('syncBtn');
    const speedSelect = document.getElementById('speedSelect');
    const loopBtn = document.getElementById('loopBtn');
    const timelineHandle = document.getElementById('timelineHandle');
    const timelineProgress = document.getElementById('timelineProgress');
    const timelineTrack = document.getElementById('timelineTrack');
    const currentTimeSpan = document.getElementById('currentTime');
    const totalTimeSpan = document.getElementById('totalTime');
    
    let isPlaying = false;
    let isLooping = false;
    let loopStart = 0;
    let loopEnd = 0;
    let currentAnnotationType = 'text';
    let annotations = [];
    let animationId = null;

    // 初始化视频
    initializeVideos();

    // 加载视频文件
    function initializeVideos() {
        const videoData = JSON.parse(localStorage.getItem('compareVideos'));
        if (videoData) {
            video1.src = videoData.video1.url;
            video2.src = videoData.video2.url;
            
            // 更新视频标签
            document.getElementById('video1Label').textContent = videoData.video1.name;
            document.getElementById('video2Label').textContent = videoData.video2.name;
        }

        // 视频加载完成后更新时间显示
        video1.addEventListener('loadedmetadata', updateTimeDisplay);
        video2.addEventListener('loadedmetadata', updateTimeDisplay);
    }

    // 播放控制
    playBtn.addEventListener('click', playVideos);
    pauseBtn.addEventListener('click', pauseVideos);

    function playVideos() {
        video1.play();
        video2.play();
        isPlaying = true;
        updateTimelineLoop();
        showToast('开始播放');
    }

    function pauseVideos() {
        video1.pause();
        video2.pause();
        isPlaying = false;
        if (animationId) {
            cancelAnimationFrame(animationId);
        }
        showToast('暂停播放');
    }

    // 同步按钮
    syncBtn.addEventListener('click', syncVideos);

    function syncVideos() {
        const currentTime = video1.currentTime;
        video2.currentTime = currentTime;
        showToast('视频已同步');
    }

    // 倍速控制
    speedSelect.addEventListener('change', function() {
        const speed = parseFloat(this.value);
        video1.playbackRate = speed;
        video2.playbackRate = speed;
        showToast(`播放速度: ${speed}×`);
    });

    // 循环播放
    loopBtn.addEventListener('click', toggleLoop);

    function toggleLoop() {
        isLooping = !isLooping;
        
        if (isLooping) {
            loopBtn.classList.add('bg-blue-500', 'text-white');
            loopBtn.classList.remove('hover:bg-gray-200');
            showLoopPanel();
        } else {
            loopBtn.classList.remove('bg-blue-500', 'text-white');
            loopBtn.classList.add('hover:bg-gray-200');
            hideLoopPanel();
        }
    }

    // 时间轴控制
    let isDragging = false;

    timelineHandle.addEventListener('mousedown', startDrag);
    timelineHandle.addEventListener('touchstart', startDrag);

    function startDrag(e) {
        isDragging = true;
        e.preventDefault();
        document.addEventListener('mousemove', drag);
        document.addEventListener('touchmove', drag);
        document.addEventListener('mouseup', stopDrag);
        document.addEventListener('touchend', stopDrag);
    }

    function drag(e) {
        if (!isDragging) return;
        
        const rect = timelineTrack.getBoundingClientRect();
        const x = (e.clientX || e.touches[0].clientX) - rect.left;
        const percentage = Math.max(0, Math.min(1, x / rect.width));
        
        updateTimelinePosition(percentage);
        
        if (video1.duration) {
            const newTime = percentage * video1.duration;
            video1.currentTime = newTime;
            video2.currentTime = newTime;
        }
    }

    function stopDrag() {
        isDragging = false;
        document.removeEventListener('mousemove', drag);
        document.removeEventListener('touchmove', drag);
        document.removeEventListener('mouseup', stopDrag);
        document.removeEventListener('touchend', stopDrag);
    }

    // 时间轴点击跳转
    timelineTrack.addEventListener('click', function(e) {
        if (e.target === timelineHandle) return;
        
        const rect = this.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const percentage = x / rect.width;
        
        if (video1.duration) {
            const newTime = percentage * video1.duration;
            video1.currentTime = newTime;
            video2.currentTime = newTime;
            updateTimelinePosition(percentage);
        }
    });

    // 更新时间轴位置
    function updateTimelinePosition(percentage) {
        timelineHandle.style.left = `${percentage * 100}%`;
        timelineProgress.style.width = `${percentage * 100}%`;
    }

    // 时间轴缩放
    document.getElementById('zoomIn').addEventListener('click', function() {
        showToast('时间轴放大');
    });

    document.getElementById('zoomOut').addEventListener('click', function() {
        showToast('时间轴缩小');
    });

    // 时间更新循环
    function updateTimelineLoop() {
        if (isPlaying) {
            updateTimeDisplay();
            
            // 检查循环播放
            if (isLooping && video1.currentTime >= loopEnd && loopEnd > 0) {
                video1.currentTime = loopStart;
                video2.currentTime = loopStart;
            }
            
            animationId = requestAnimationFrame(updateTimelineLoop);
        }
    }

    function updateTimeDisplay() {
        if (video1.duration) {
            const current = video1.currentTime;
            const duration = video1.duration;
            const percentage = current / duration;
            
            updateTimelinePosition(percentage);
            currentTimeSpan.textContent = formatTime(current);
            totalTimeSpan.textContent = formatTime(duration);
            
            // 更新时间刻度
            updateTimelineScale(duration);
        }
    }

    function updateTimelineScale(duration) {
        const scale = document.getElementById('timelineScale');
        const intervals = 5;
        const step = duration / (intervals - 1);
        
        scale.innerHTML = '';
        for (let i = 0; i < intervals; i++) {
            const time = i * step;
            const span = document.createElement('span');
            span.textContent = formatTime(time);
            scale.appendChild(span);
        }
    }

    function formatTime(seconds) {
        const mins = Math.floor(seconds / 60);
        const secs = Math.floor(seconds % 60);
        return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
    }

    // 循环设置面板
    function showLoopPanel() {
        const panel = document.getElementById('loopPanel');
        panel.classList.remove('translate-y-full');
        
        // 设置当前时间为循环开始点
        const currentTime = video1.currentTime || 0;
        document.getElementById('loopStartTime').value = formatTime(currentTime);
        document.getElementById('loopEndTime').value = formatTime(Math.min(currentTime + 10, video1.duration || currentTime + 10));
    }

    function hideLoopPanel() {
        document.getElementById('loopPanel').classList.add('translate-y-full');
    }

    // 循环设置确认
    document.getElementById('confirmLoop').addEventListener('click', function() {
        const startTime = parseTimeString(document.getElementById('loopStartTime').value);
        const endTime = parseTimeString(document.getElementById('loopEndTime').value);
        
        if (startTime < endTime) {
            loopStart = startTime;
            loopEnd = endTime;
            updateLoopMarkers();
            hideLoopPanel();
            showToast('循环区间已设置');
        } else {
            showToast('结束时间必须大于开始时间');
        }
    });

    document.getElementById('cancelLoop').addEventListener('click', function() {
        hideLoopPanel();
        isLooping = false;
        loopBtn.classList.remove('bg-blue-500', 'text-white');
        loopBtn.classList.add('hover:bg-gray-200');
    });

    function parseTimeString(timeStr) {
        const parts = timeStr.split(':');
        return parseInt(parts[0]) * 60 + parseInt(parts[1]);
    }

    function updateLoopMarkers() {
        const duration = video1.duration || 100;
        const startPercent = (loopStart / duration) * 100;
        const endPercent = (loopEnd / duration) * 100;
        
        document.getElementById('loopStart').style.left = `${startPercent}%`;
        document.getElementById('loopEnd').style.left = `${endPercent}%`;
        document.getElementById('loopRegion').style.left = `${startPercent}%`;
        document.getElementById('loopRegion').style.right = `${100 - endPercent}%`;
    }

    // 批注功能
    document.getElementById('addAnnotation').addEventListener('click', showAnnotationPanel);

    function showAnnotationPanel() {
        document.getElementById('annotationPanel').classList.remove('translate-y-full');
    }

    function hideAnnotationPanel() {
        document.getElementById('annotationPanel').classList.add('translate-y-full');
    }

    // 批注类型切换
    document.getElementById('textTypeBtn').addEventListener('click', function() {
        setAnnotationType('text');
    });

    document.getElementById('audioTypeBtn').addEventListener('click', function() {
        setAnnotationType('audio');
    });

    function setAnnotationType(type) {
        currentAnnotationType = type;
        const textBtn = document.getElementById('textTypeBtn');
        const audioBtn = document.getElementById('audioTypeBtn');
        const textArea = document.getElementById('annotationText');
        const audioRecorder = document.getElementById('audioRecorder');
        
        if (type === 'text') {
            textBtn.classList.add('bg-blue-500', 'text-white');
            textBtn.classList.remove('bg-gray-100', 'text-gray-700', 'hover:bg-gray-200');
            audioBtn.classList.remove('bg-blue-500', 'text-white');
            audioBtn.classList.add('bg-gray-100', 'text-gray-700', 'hover:bg-gray-200');
            textArea.classList.remove('hidden');
            audioRecorder.classList.add('hidden');
        } else {
            audioBtn.classList.add('bg-blue-500', 'text-white');
            audioBtn.classList.remove('bg-gray-100', 'text-gray-700', 'hover:bg-gray-200');
            textBtn.classList.remove('bg-blue-500', 'text-white');
            textBtn.classList.add('bg-gray-100', 'text-gray-700', 'hover:bg-gray-200');
            textArea.classList.add('hidden');
            audioRecorder.classList.remove('hidden');
        }
    }

    // 录音功能
    let mediaRecorder;
    let audioChunks = [];
    let isRecording = false;

    document.getElementById('recordBtn').addEventListener('click', function() {
        if (!isRecording) {
            startRecording();
        } else {
            stopRecording();
        }
    });

    async function startRecording() {
        try {
            const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
            mediaRecorder = new MediaRecorder(stream);
            audioChunks = [];
            
            mediaRecorder.ondataavailable = event => {
                audioChunks.push(event.data);
            };
            
            mediaRecorder.start();
            isRecording = true;
            document.getElementById('recordBtn').textContent = '🛑 停止录音';
            document.getElementById('recordingStatus').textContent = '正在录音...';
        } catch (error) {
            showToast('无法访问麦克风');
        }
    }

    function stopRecording() {
        if (mediaRecorder && isRecording) {
            mediaRecorder.stop();
            isRecording = false;
            document.getElementById('recordBtn').textContent = '🎤 开始录音';
            document.getElementById('recordingStatus').textContent = '录音完成';
        }
    }

    // 保存批注
    document.getElementById('saveAnnotation').addEventListener('click', function() {
        const currentTime = video1.currentTime || 0;
        const content = currentAnnotationType === 'text' ? 
            document.getElementById('annotationText').value.trim() : 
            '语音批注';
            
        if (currentAnnotationType === 'text' && !content) {
            showToast('请输入批注内容');
            return;
        }
        
        const annotation = {
            id: Date.now(),
            timestamp: currentTime,
            type: currentAnnotationType,
            content: content,
            audioData: currentAnnotationType === 'audio' ? audioChunks : null
        };
        
        annotations.push(annotation);
        addAnnotationMarker(annotation);
        hideAnnotationPanel();
        
        // 清空输入
        document.getElementById('annotationText').value = '';
        document.getElementById('recordingStatus').textContent = '';
        
        showToast('批注已保存');
    });

    document.getElementById('cancelAnnotation').addEventListener('click', hideAnnotationPanel);

    function addAnnotationMarker(annotation) {
        const duration = video1.duration || 100;
        const percentage = (annotation.timestamp / duration) * 100;
        
        const marker = document.createElement('div');
        marker.className = 'absolute top-1/2 w-3 h-3 bg-yellow-500 border-2 border-white rounded-full shadow-lg cursor-pointer transform -translate-y-1/2';
        marker.style.left = `${percentage}%`;
        marker.title = annotation.content;
        marker.addEventListener('click', function() {
            video1.currentTime = annotation.timestamp;
            video2.currentTime = annotation.timestamp;
            showToast(`跳转到 ${formatTime(annotation.timestamp)}`);
        });
        
        document.getElementById('annotationMarkers').appendChild(marker);
    }

    // 返回按钮
    document.getElementById('backBtn').addEventListener('click', function() {
        window.location.href = 'index.html';
    });

    // 菜单按钮
    document.getElementById('menuBtn').addEventListener('click', function() {
        showToast('菜单功能开发中...');
    });

    // 工具函数
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