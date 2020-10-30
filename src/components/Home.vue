<template>
  <div>
    <el-container>
    <el-header>
    <nav-menu></nav-menu>
    </el-header>
    <el-main>
    <router-view/>
    </el-main>
    </el-container>
  </div>
</template>

<script>
 import NavMenu from './NavMenu';
  export default {
    name: 'Home',
    components:{NavMenu}
  }
</script>

<style scoped>

</style>
