1. Spark Generator usage: ` rails g panda:api panda/panda::app --name 'app版本管理' --module 'test' -f`
   1. panda:api, installer的名字
   2. panda/panda:app, 模型的名字
   3. `--name`, 这个功能的中文名
   4. `--module`, 这个功能所属的模块, 也是namespace, 用于放置api文件所在的目录
   5. `-f`, 强制生成文件