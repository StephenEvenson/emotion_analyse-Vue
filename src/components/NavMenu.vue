<template>
    <el-menu
      mode="horizontal"
      background-color="white"
      text-color="#222"
      active-text-color="red"
      >
      <div>
       <el-row :gutter="20">
    <el-col :span="3" :offset="9">
        <el-radio v-model="radio" label="1" style="display:inline">
        <div style="float:right;display:inline;margin-top:2%"><el-avatar shape="square" :size="50" :src="url1"></el-avatar></div>
        <div class="nameTXT">
            b站
        </div>
        </el-radio>
        </el-col>
    <el-col :span="3" :offset="1" >
        <el-radio v-model="radio" label="2" style="display:inline">
              <div style="float:right;display:inline;margin-top:2%"><el-avatar shape="square" :size="50" :src="url2"></el-avatar></div>
        <div class="nameTXT">
            微博 
        </div>
        </el-radio>
    </el-col>
    </el-row>
</div>
    </el-menu>
</template>

<script>
  export default {
    name: 'NavMenu',
    data () {
      return {
        radio:'1',
        url1: require('../assets/bilibili.jpg'),
        url2: require('../assets/weibo.jpg'),
      }
    }
  }
</script>

<style scoped>
  .nameTXT{ font-family:Cursive;font-size:35px;font-weight:bold;}
</style>

