modelString = "
model
{
for (i in 1:n)
{
   # Poisson likelihood for observed counts
   y[i] ~ dpois(mu[i])
   mu[i] <- e[i] * theta[i]
   # Relative Risk
   theta[i] ~ dgamma(a,b)
   r[i] <- y[i] - mu[i]
}

# Prior distributions for 'population' parameters
a ~ dexp(10)
b ~ dexp(10)

# Population mean and population variance
mean <- a/b
var <- a/pow(b,2)
}
"
x = list(y = c(9,6,6,5,5,5,4,4,3,2,2,2,2,2,1,1,1,1,1,1),
         e = c(8,7,7,7,7,7,4,4,4,3,2,1,1,1,1,1,1,1,1,1),
         n = 20)
writeLines(modelString, con="model.txt")
modelCheck("model.txt")
modelData(bugsData(x))
modelCompile(numChains=2)
modelGenInits()
samplesSet("theta")
samplesSet("r")
samplesSet("mu")
chainLength = 10000
modelUpdate(chainLength)
#thetaSample = samplesSample("theta[1]")
thetaSummary = samplesStats("theta")
rSummary = samplesStats("r")
muSummary = samplesStats("mu")
# samplesHistory("theta")