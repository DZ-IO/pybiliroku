# pybiliroku

这是一个使用 python 写的 B 站录播机。

录播的逻辑部分参考了 [zyzsdy/biliroku](https://github.com/zyzsdy/biliroku)

## Requirements

见 [Pipfile](Pipfile)

## 使用方法

### 使用基于浏览器的录播机管理器

`$ python manager.py`

然后用浏览器打开 <http://127.0.0.1:2004/> ，也可以用手机等移动设备隔空管理。

中间输入房间号点击加号开始录制。

右上角可以在设置里设置保存位置（默认在录播机文件夹下 streams 文件夹里）。
和录播机启动时自动开始录制某些房间（多个房间以逗号隔开，逗号旁边没有空格）

### 不使用录播机管理器

该方法适合高级用户使用

`$ python roku.py --room-id *(房间号)* --savepath streams/{original_room_id}/{start_time}-{title}`

上面的命令开启录播机一次。如果该房间正在直播，就开始录制，一旦出现错误就退出。如果没在直播，直接退出。

`$ python roku_loop.py --room-id *(房间号)* --savepath streams/{original_room_id}/{start_time}-{title}`

上面的命令反复开启录播机。可以做到等待开播后自动录制，出错后自动恢复。

### 在 docker 里使用本软件

1. 构建（只需运行一次）

   ```bash
   docker build -t pybiliroku .
   ```

2. 基本启动

   ```bash
   docker run -d --name pybiliroku -p 2004:2004 -v pybiliroku:/app/streams/recoards pybiliroku
   # 也可启用时区和自启动功能
   docker run -d --name pybiliroku -p 2004:2004 -v pybiliroku:/app/streams/recoards -v /etc/localtime:/etc/localtime:ro --restart=always pybiliroku
   docker run -d --name pybiliroku -p 2004:2004 -v pybiliroku:/app/streams/recoards -v /etc/localtime:/etc/localtime:ro --restart=always pybiliroku
   ```

   然后参阅[基于浏览器的录播机管理器](#使用基于浏览器的录播机管理器)中的使用方法使用  
   特别提示：**不要修改保存位置**(修改保存位置请直接修改-v 参数)

3. 高级启动（不用管理器）

   ```bash
   docker run -d --name pybiliroku -p 2004:2004 -v pybiliroku:/app/streams/recoards -v /etc/localtime:/etc/localtime:ro pybiliroku roku.py --room-id *(房间号)* --savepath streams/{original_room_id}/{start_time}-{title}
   ```
