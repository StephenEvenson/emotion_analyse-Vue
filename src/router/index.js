import Vue from 'vue'
import Router from 'vue-router'
// import AppIndex from '@/components/home/AppIndex'
import Login from '@/components/Login'
// import Contact from '@/components/Contact'
import Home from '@/components/Home'
import Analysis from '@/components/Analysis'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    // 下面都是固定的写法
    {
      path: '/',
      name: 'Home',
      component:Home,
      //home页面不需要被访问
      redirect:'/analysis',
      children:[
        // {
        //   path: '/contact',
        //   name: 'Contact',
        //   component: Contact,
        //   // meta: {
        //   //   requireAuth: true
        //   // }
        // },
        {
          path: '/analysis',
          name: 'Analysis',
          component: Analysis
        }
      ]
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    ]
})
