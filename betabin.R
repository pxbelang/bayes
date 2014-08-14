library(BRugs)
modelString = "
model {
p ~ dbeta(a,b)
x ~ dbin(p,n)

}
"
writeLines(modelString, con="model.txt")
modelCheck("model.txt")
dataList = list(n = 25, x=11, a=1, b=1)
modelData(bugsData(dataList))
modelCompile()
modelGenInits()
samplesSet("p")
samplesSet("a")
chainLength = 10000
modelUpdate(chainLength)
pSample = samplesSample("p")
pSummary = samplesStats("p")