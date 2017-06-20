#################### 自动更新 jenkins 中构建的H5 ################## 
#
#
#  临时文件放在桌面，自动copy到项目目录下，下载成功后自动删除临时目录
#################################################################

JENKINS_SERVER=""

# 权限认证
userName=""
password=""

# 下载后文件重命名
Html_name="h5"

# 下载后文件输出目录
export_path=~/Desktop/jenkins_h5

# 进入工程文件层级
cd ..

# 工程目录
Project_Name=$(cd `dirname $0`; pwd)

#h5 导出目录
ProjectPath_h5=${Project_Name}/${Html_name}

#获取最新版本号
lastStableBuildBumber=`curl --silent ${JENKINS_SERVER}/job/bdapp-h5/lastStableBuild/buildNumber --user ${userName}:${password}`

echo 获取 JENKINS 中 H5 的最新版本号：$lastStableBuildBumber

#创建导出目录
if [[ -d "${export_path}" ]] ; then
	echo $export_path
else
	mkdir -pv $export_path
fi

echo 开始文件下载.....

#下载最新文件
lastH5URL="${JENKINS_SERVER}/job/bdapp-h5/lastSuccessfulBuild/artifact/bdapp-repo/h5/app/h5_${lastStableBuildBumber}.zip"

downloadZip=${export_path}/h5_${lastStableBuildBumber}.zip

curl -o ${downloadZip} --user ${userName}:${password} $lastH5URL

echo "###################################   文件缓存清理   #########################################"

if [ -d "${ProjectPath_h5}" ]; then
	rm -rf ${ProjectPath_h5}
else
	echo 原文件不存在
fi

#解压文件
unzip ${downloadZip} -d ${export_path} 

#文件移动并重命名    
mv -f ${export_path}/build ${ProjectPath_h5}

if [[ -d "${ProjectPath_h5}" ]]; then
	echo "################ 😀😀😀 h5 更新成功 😀😀😀################################"
else
	echo "################ 文件更新失败,未发现 ${ProjectPath_h5} ################################"
    exit 1
fi

if [ -d "${export_path}" ]; then
	rm -rf ${export_path}
	echo "################ 清理临时文件成功 ################################"
else
	echo "################ 清理临时文件失败 ################################"
fi

