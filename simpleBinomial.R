library(BRugs)
modelString = "
model {
   for (i in 1:nFlips) {
      y[i] ~ dbern(theta)
   }
   theta ~ dbeta(priorA, priorB)
   priorA <- 1
   priorB <- 1
}
"
writeLines(modelString, con="model.txt")
modelCheck("model.txt")
dataList = list(nFlips = 14, y = c(1,1,1,1,1,1,1,1,1,1,1,0,0,0))
modelData(bugsData(dataList))
modelCompile()
modelGenInits()
samplesSet("theta")
chainLength = 10000
modelUpdate(chainLength)
thetaSample = samplesSample("theta")
thetaSummary = samplesStats("theta")