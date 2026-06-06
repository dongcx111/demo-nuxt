module.exports = {
    apps: [{
        name: 'nuxt4-app',
        script: '.output/server/index.mjs',

        // 集群模式：使用所有可用CPU核心
        instances: 'max',
        exec_mode: 'cluster',

        // 环境变量
        env: {
            NODE_ENV: 'production',
            NITRO_PORT: 3000,
            NITRO_HOST: '0.0.0.0'
        },

        // 自动重启配置
        autorestart: true,
        watch: false, // Docker中不要启用文件监听
        max_memory_restart: '1G', // 超过1GB内存自动重启
        min_uptime: '10s', // 应用至少运行10秒才认为启动成功
        max_restarts: 10, // 1分钟内最多重启10次

        // 优雅关闭配置
        kill_timeout: 5000, // 给进程5秒时间完成当前请求
        listen_timeout: 3000, // 等待3秒让应用监听端口

        // 日志配置
        error_file: './logs/err.log',
        out_file: './logs/out.log',
        log_file: './logs/combined.log',
        time: true, // 日志添加时间戳
        merge_logs: true, // 合并所有实例的日志
        log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
        // 日志轮转配置
        log_rotate: {
            max_size: '10M', // 单个日志文件最大10MB
            retain: 30, // 保留最近30个日志文件
            compress: true // 压缩旧日志
        }

    }]
}
