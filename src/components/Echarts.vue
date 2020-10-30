<template>
  <div class="echarts-container">
    <el-row :gutter="20">
      <el-col :xs="24" :sm="24" :md="12" :lg="12" :xl="8">
        <el-card shadow="hover">
          <div slot="header">柱状图</div>
          <div>
            <vab-chart id="chart" autoresize :options="chart1" />
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
  import * as echarts from "echarts";
  import VabChart from "@/plugins/echarts";

  export default {
    name: "Echarts",
    components: {
      VabChart,
    },
    data() {
      return {
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
            data: ["销售水量", "主营业务"],
          },
          xAxis: {
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
              name: "亿元",
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
              name: "同比",
              position: "right",
              splitLine: {
                show: false,
              },
              axisTick: {
                show: false,
              },
              axisLine: {
                show: false,
              },
              axisLabel: {
                show: true,
                formatter: "{value} %", //右侧Y轴文字显示
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
              name: "销售水量",
              type: "line",
              smooth: true, //平滑曲线显示
              itemStyle: {
                color: "#058cff",
              },
              areaStyle: {
                color: "rgba(5,140,255, 0.2)",
              },
              data: [4.2, 3.8, 4.8, 3.5, 2.9, 2.8, 3, 5],
            },
            {
              name: "主营业务",
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
              data: [4.2, 3.8, 4.8, 3.5, 2.9, 2.8, 3, 5],
            },
          ],
        },
      };
    },
    mounted() {},
    methods: {},
  };
</script>

<style scoped>

</style>
