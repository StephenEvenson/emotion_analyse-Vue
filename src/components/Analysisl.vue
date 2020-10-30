<template>
<div>
  <bg-color></bg-color>
  <div style="margin: 50px 0px 50px 0px; background: 0 0; "></div>
  <el-row>
      <el-col :span="12" :offset="6" >
        <el-card shadow="never">
          <div>
              <el-input placeholder="请输入视频链接或空间链接"
              style="width: 560px;margin: 0px;padding: 0px;"
              v-model="URL"
              clearable>
                  <template slot="prepend">Https://</template>
              </el-input>
          </div>
          <div style="margin: 20px 0px 20px 0px; background: 0 0; "></div>

          <div style="float:left;padding: 0 0 0 8%">
              请输入分析视频数:
              <el-input style="width: 65px;margin: 2px;"
                  size="small"
                  v-model="count"
                  clearable>
                  </el-input>
          </div>
          <div> <el-button type="primary" plain style="float:right;margin: 10px" @click="sendUrl">开始分析</el-button> </div>
        </el-card>
      </el-col>
  </el-row>

   <div style="margin: 50px 0px 50px 0px; background: 0 0;"></div>

    <el-row>
    <el-col :span="20" :offset="2" >
    <el-card shadow="never">
    <div>
    <div class="nameTXT" style="float:left;font-size:25px;display:inline">
        关键词分析结果
    </div>
    <el-button type="primary" size="small" style="float:left;margin: 0 5px 0 40px;" @click="checkWord">点击查看</el-button>

    </div>

<div style="margin: 50px 0px 50px 0px; background: 0 0;"></div>

    <div v-for="(item,key) in vlist" :key="key">
    <el-col :span="10" style="margin:20px">
      <el-card :body-style="{ padding: '0px' }">
            <div slot="header">
            <span>{{item.title}}</span>
          </div>
        <div id="app">
          <wordcloud
            :data="item.word_fq"
            nameKey="name"
            valueKey="value"
            :color="myColors"
            :showTooltip="true"
            :wordClick="wordClickHandler">
          </wordcloud>
        </div>
        <div slot="header" style="margin-top:2%">
            <span>up主：   {{item.up}}</span>
          </div>
    </el-card>
    </el-col>
    </div>
</el-card>
</el-col>
</el-row>

<div style="margin: 50px 0px 50px 0px; background: 0 0;"></div>

    <el-row>
    <el-col :span="20" :offset="2" >
    <el-card shadow="never">
    <div>
    <div class="nameTXT" style="float:left;font-size:25px;display:inline">
        情感分析结果
    </div>
    <el-button type="primary" size="small" style="float:left;margin: 0 5px 0 60px;">点击查看</el-button>

    </div>

<div style="margin: 50px 0px 50px 0px; background: 0 0;"></div>

<!-- <div v-for="(item,key) in vlist" :key="key"> -->
    <el-col :span="10" style="margin:20px">
      <el-card :body-style="{ padding: '0px' }">
            <!-- <div slot="header">
            <span>{{item.title}}</span>
          </div> -->
       <div slot="header">柱状图</div>
        <div>
          <vab-chart autoresize :options="chart1" />
        </div>
        <!-- <div slot="header" style="margin-top:2%">
            <span>up主：   {{item.up}}</span>
          </div> -->
    </el-card>
    </el-col>
    <!-- </div> -->

    </el-card>
    </el-col>
    </el-row>
</div>
</template>

<script>
import Js2WordCloud from 'js2wordcloud';
import wordcloud from 'vue-wordcloud';
import BgColor from './BgSet';
import * as echarts from "echarts";
import VabChart from "../plugins/echarts";

  export default {
    components: {BgColor, wordcloud,VabChart},
    name: 'Analysis',
    data(){
      return{
         count: 0,
        //  cardLoading: false,
         URL: '',
         up:'',
         vlist:[],
        myColors: ['#1f77b4', '#629fc9', '#94bedb', '#c9e0ef'],

        sum:[],
        pos:[],
        neg:[],
        duration:0,
        interval:0,
        n:0,

        chart1: {
          grid: {
            top: "25%",
            bottom: "10%",
          },
          tooltip: {
            trigger: "axis",
            axisPointer: {
              type: "shadow",
              label: {
                show: true,
              },
            },
          },
          legend: {
            data: ["情感总值"],
          },
          xAxis: {
            name: "时间",
            data: [
              "当年完成水量",
              "去年同期水量",
              "滚动目标值水量",
              "全年目标值水量",
              "当年完成金额",
              "去年同期金额",
              "滚动目标金额",
              "全年目标值",
            ],
            axisLine: {
              show: true, //隐藏X轴轴线
            },
            axisTick: {
              show: true, //隐藏X轴刻度
            },
            axisLabel: {
              show: true,
            },
          },
          yAxis: [
            {
              type: "value",
              name: "情感值",
              splitLine: {
                show: false,
              },
              axisTick: {
                show: true,
              },
              axisLine: {
                show: true,
              },
              axisLabel: {
                show: true,
              },
            },
            {
              type: "value",
              gridIndex: 0,
              min: 50,
              max: 100,
              splitNumber: 8,
              splitLine: {
                show: false,
              },
              axisLine: {
                show: false,
              },
              axisTick: {
                show: false,
              },
              axisLabel: {
                show: false,
              },
              splitArea: {
                show: true,
                areaStyle: {
                  color: ["rgba(250,250,250,0.0)", "rgba(250,250,250,0.05)"],
                },
              },
            },
          ],
          series: [

            {
              name: "情感总值",
              type: "bar",
              barWidth: 15,
              itemStyle: {
                normal: {
                  color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                    {
                      offset: 0,
                      color: "#00FFE3",
                    },
                    {
                      offset: 1,
                      color: "#4693EC",
                    },
                  ]),
                },
              },
              data: sum,
            },
          ],
        },

      }
    },
    methods: {
        sendUrl(){
        var _this = this
         const loading = this.$loading({
          lock: true,
          text: '正在分析中...',
          spinner: 'el-icon-loading',
          background: 'rgba(0, 0, 0, 0.7)'
        });
        if(this.URL!=''){
        this.$axios
          .post('/bilibili/bullet_screen/',{
              url:"https://"+this.URL,
              num:this.count
          }).then(resp => {
          loading.close();
          if (resp && resp.data.code === 200) {
           _this.$message({
             message: '弹幕分析成功',
              type: 'success'
             });
          }
        })
        }
        },

      wordClickHandler(name, value, vm) {
        console.log('wordClickHandler', name, value, vm);
      },

        checkWord(){
        var _this = this;
        this.$axios
          .post('/bilibili/word_fq/',{url:"https://"+this.URL}).then(resp => {
          if (resp && resp.data.code === 200) {
            _this.vlist = resp.data.data.vlist;
            _this.count = resp.data.data.count;
            _this.up = resp.data.data.up;
          }
        })
      },
        checkDiagram(){
        var _this = this;
        this.$axios
          .post('/bilibili/diagram/',{url:"https://"+this.URL}).then(resp => {
          if (resp && resp.data.code === 200) {
            _this.vlist = resp.data.data.vlist;
            _this.count = resp.data.data.count;
            _this.up = resp.data.data.up;
            _this.pos = resp.data.data.vlist.diagram.pos;
            _this.neg = resp.data.data.vlist.diagram.neg;
            _this.average = resp.data.data.vlist.diagram.average;
            _this.int = resp.data.data.vlist.diagram.interval;
          }
        })
      }

    }
  }
</script>

<style scoped>
.el-col {
   align-content: center;
}
 .nameTXT{ font-family:Cursive;font-size:35px;font-weight:bold;
}
.image {
    width: 50%;
    display: block;
  }
  .echarts {
  width: 100%;
}
</style>
