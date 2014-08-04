library(BRugs)
modelString = "
model
{
   mu ~ dnorm(0,1)
   y ~ dnorm(mu,1)
}

"
datalist = list(y=20)
writeLines(modelString, con="model.txt")
modelCheck("model.txt")
modelData(bugsData(datalist))
modelCompile()
modelGenInits()
samplesSet("mu")
samplesSet("y")
chainLength = 1000
modelUpdate(chainLength)
muSample = samplesSample("mu")
muSummary = samplesStats("mu")
ySample = samplesSample("y")
ySummary = samplesStats("y")