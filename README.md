# Jenkins_Update
###背景：
    在 hybrid 开发中，部分 html 文件是先保存在本地，线上动态更新，在获取最新的构建 h5 版本时，需要手动下载。该脚本主要用于Jenkins中最新 H5 文件的下载，并替换 project 中的文件。

###使用方法：

####修改脚本中变量
* userName
* password
* JENKINS_SERVER
* Html_name

>其中 Html_name 为重命名后文件名称    
> userName 和 password 为 JENKINS 的用户名和密码

####创建目录
    以 iOS 项目为例,在.xcodeproj目录下新建AutoUpdateScript文件夹，放入脚本文件
####运行脚本

```shell
sh ./AutoUpdateH5.sh 
```

####工程结构
        
    |--.xcodeproj
    |--AutoUpdateScript
       |-AutoUpdateH5.sh
    |--h5   
