library(BRugs)
modelString = "
model
{
   mu ~ dbeta(1,1)I(0.2,0.45)
   r ~ dbin(mu, N)
   mu2 ~ dbeta(1,1)I(0.2,0.45)
   r2 ~ dbin(mu2, N2)
   ratio <- mu2/mu
   diff <- mu2 - mu
}
"
datalist = list(N=14, r=4, N2=12, r2=5)
writeLines(modelString, con="model.txt")
modelCheck("model.txt")
modelData(bugsData(datalist))
modelCompile()
modelGenInits()
samplesSet("mu")
samplesSet("mu2")
samplesSet("r")
samplesSet("ratio")
chainLength = 100000
modelUpdate(chainLength)
muSample = samplesSample("mu")
muSummary = samplesStats("mu")
rSample = samplesSample("r")
rSummary = samplesStats("r")
ratioSample = samplesSample("ratio")
ratioSummary = samplesStats("ratio")
hist(muSample)
hist(ratioSample)