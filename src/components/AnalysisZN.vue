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
    <el-col :span="19" :offset="2" style="margin-bottom:30px" >
      <el-card :body-style="{ padding: '0px' }">
            <div slot="header">
            <span>{{item.title}}</span>
            <div style="margin: 2px 0px 2px 0px"></div>
            <span>up主：   {{item.up}}</span>
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
    <el-button type="primary" size="small" style="float:left;margin: 0 5px 0 60px;" @click="checkDiagram">点击查看</el-button>
    </div>

<div style="margin: 50px 0px 50px 0px; background: 0 0;"></div>


<div v-for="(item,key) in vlistDiagram" :key="key">
    <el-col :span="11" style="margin:20px">
      <el-card :body-style="{ padding: '0px' }">
            <div slot="header">
            <span class="nameTXT" style="font-size:30px">情感总体分析</span>
          </div>
       <div slot="header" style="font-size:10px">{{item.title}}</div>
        <div>
          <vab-chart autoresize :options="chart1" />
        </div>
        </el-card>
    </el-col>

<el-col :span="11" style="float:right;margin:20px">
         <el-card :body-style="{ padding: '0px' }">
            <div slot="header">
            <span class="nameTXT" style="font-size:30px">情感细节分析</span>
          </div>
               <div slot="header" style="font-size:10px">{{item.title}}</div>
        <div>
          <vab-chart autoresize :options="chart2" />
        </div>
         </el-card>
</el-col>
    </div>


    </el-card>
    </el-col>
    </el-row>
</div>
</template>

<script>
import wordcloud from 'vue-wordcloud';
import BgColor from './BgSet';
import * as echarts from "echarts";
import VabChart from "@/plugins/echarts";

  export default {
    components: {BgColor, wordcloud,VabChart},
    name: 'Analysis',
    data(){
      return{
       URL: '',
       count: 0,
       countWord:0,
       countDiagram:0,
      //  cardLoading: false,
       up:'',
       vlist:[],
       vlistDiagram:[],
       myColors: ['#1f77b4', '#629fc9', '#94bedb', '#c9e0ef'],
       pos:[],
       neg:[],
       average: [4.2, 3.8, 4.8, 3.5, 5],
       sum: [4, 1, 3, 8, 9],
       intervals:[5,10,15,20],
       interval: 60,
       n: 5,
       data: [30, 60, 90, 120, 150],
       chart1: {},
       chart2: {},

      }
    },
    mounted() {
      this.chart1 = {
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
          data: ["情感总值", "情感均值"],
        },
        xAxis: {
          name: "时间/s",
          data: this.data,
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
            name: "",
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
            type: "line",
            smooth: true, //平滑曲线显示
            itemStyle: {
              color: "#058cff",
            },
            areaStyle: {
              color: "rgba(5,140,255, 0.2)",
            },
            data: this.sum,
          },
          {
            name: "情感均值",
            type: "bar",
            barWidth: 20,
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
            data: this.average,
          },
        ],
      };
      this.chart2 = {
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
                  data: ["消极情感", "积极情感"],
                },
                xAxis: {
                  name: "时间/s",
                  data: this.data,
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
                    splitNumber: 5,
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
                    name: "消极情感",
                    type: "bar",
                    barWidth: 15,
                    itemStyle: {
                      normal: {
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                          {
                            offset: 0,
                            color: "#ffe57f",
                          },
                          {
                            offset: 1,
                            color: "#e5b700",
                          },
                        ]),
                      },
                    },
                    data: this.neg,
                  },

                  {
                    name: "积极情感",
                    type: "bar",
                    barWidth: 15,
                    itemStyle: {
                      normal: {
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                          {
                            offset: 0,
                            color: "#00ff66",
                          },
                          {
                            offset: 1,
                            color: "#00993d",
                          },
                        ]),
                      },
                    },
                    data: this.pos,
                  },
                ],
              };

    },

    watch: {
      interval(val, oldValue) {
        let intervals = []
        for (let i = 1; i <= this.n; i++){
          intervals.push(i*val)
        }
        this.intervals = intervals
        this.setData(intervals);
      },
      n(val, oldValue) {
        let intervals = []
        for (let i = 1; i <= val; i++){
          intervals.push(i*this.interval)
        }
        this.intervals = intervals
        this.setData(intervals);
      },
      sum(val, oldValue) {
        this.setSum(val);
      },
      average(val, oldValue) {
        this.setAverage(val)
      },
      neg(val, oldValue){
         this.setNeg(val)
      },
       pos(val, oldValue){
         this.setPos(val)
      },
    },

    methods: {
     clear(){
        this.vlist=[]
     },

        sendUrl(){
        this.clear();
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
         const loading = this.$loading({
          lock: true,
          text: '正在加载词云，请稍后...',
          spinner: 'el-icon-loading',
          background: 'rgba(0, 0, 0, 0.7)'
        });
        this.$axios
          .post('/bilibili/word_fq/',{url:"https://"+this.URL}).then(resp => {
            loading.close();
          if (resp && resp.data.code === 200) {
             _this.vlist = resp.data.data.vlist;
            _this.countWord = resp.data.data.count;
            _this.up = resp.data.data.up;
          }
        })
      },

      setData(data) {
          this.chart1.xAxis.data = data;
          this.chart2.xAxis.data = data;
      },

      setSum(sum) {
          this.chart1.series[0].data = sum;
      },

      setAverage(average) {
          this.chart1.series[1].data = average;
      },

      setNeg(neg) {
          this.chart2.series[0].data = neg;
      },

      setPos(pos) {
          this.chart2.series[1].data = pos;
      },

      checkDiagram(){
        const _this = this;
        this.$axios
          .post('/bilibili/diagram/',{url:"https://"+this.URL}).then(resp => {
          if (resp && resp.data.code === 200) {
            _this.vlistDiagram = resp.data.data.vlist;
            _this.countDiagram = resp.data.data.count;
            _this.up = resp.data.data.up;
            _this.pos = resp.data.data.vlist[0].diagram.pos;
            _this.neg = resp.data.data.vlist[0].diagram.neg;
            _this.average = resp.data.data.vlist[0].diagram.average;
            _this.sum = resp.data.data.vlist[0].diagram.sum;
            _this.interval = resp.data.data.vlist[0].diagram.interval;
            _this.n = resp.data.data.vlist[0].diagram.n;
          }
        })
      },

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
