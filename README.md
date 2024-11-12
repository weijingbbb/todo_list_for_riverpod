# 项目介绍
这个是udemy上的课程：https://www.udemy.com/course/flutter-riverpod-essential-course-english

第12节的 Todo App 项目

这个项目主要是使用了riverpod来管理状态，使用了Hive来存储数据

项目是递进式的，每个分支都是一个递进的技术

递进的顺序是：
- main 最基础的状态管理
- for_enum 使用枚举对状态进行管理
- for_sealed 使用密封类替代枚举管理状态
- for_asyncvalue 使用异步状态管理
- for_hive 使用Hive对状态数据进行存储

基本上 for_asyncvalue 是最终的版本，for_hive主要是增加了存储功能。

# 运行
`flutter pub get` 安装依赖

`flutter run` 即可运行