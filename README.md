# COVID-19-Spread-Modeling-By using SEIR model

![image](https://user-images.githubusercontent.com/40909273/128638152-b7eb5906-66c0-4160-a092-5c9f7b6b0b8e.png)
<br>

We use a compartmental epidemiological model, based on the classic SEIR model, to
describe the spread and clinical progression of COVID-19. A nice primer to this sort of
model is available on Wikipedia
(https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology). It is important to
track the different clinical outcomes of infection, since they require different level of
healthcare resources to care for and may be tested and isolated at different rates.
Susceptible ( ) individuals who become infected start out in an exposed class , where
they are asymptomatic and do not transmit infection. The rate of progressing from the
exposed stage to the infected stage , where the individual is symptomatic and
infectious, occurs at rate . The clinical descriptions of the different stages of infection
are given below. Infected individuals begin with mild infection ( ), from which they either
recover, at rate , or progress to severe infection ( ), at rate . Severe infection
resolves at rate or progresses to a critical stage ( ) at rate . Individuals with
critical infection recover at rate and die at rate . Recovered individuals are tracked by class and are assumed to be protected from re-infection for life. Individuals may
transmit the infection at any stage, though with different rates. The transmission rate in
stage is described by .
<br>
## Variables
S:Susceptible individuals <br>
E: Exposed individuals - infected but not yet infectious or symptomatic <br>
I: Infected individuals in severity class . Severity increases with and we <br>
assume individuals must pass through all previous classes <br>
I1: Mild infection <br>
I2: Severe infection <br>
I3: Critical infection <br>
R: individuals who have recovered from disease and are now immune <br>
D: Dead individuals <br>
N:Total population size (constant) <br>

