import numpy as np
def laprnd(m, mu=0, sigma=1):
#LAPRND generate i.i.d. laplacian random number drawn from laplacian distribution
#   with mean mu and standard deviation sigma. 
#   mu      : mean
#   sigma   : standard deviation
#   [m, n]  : the dimension of y.
#   Default mu = 0, sigma = 1. 
#   For more information, refer to
#   http://en.wikipedia.org./wiki/Laplace_distribution

#   Author  : Elvis Chen (bee33@sjtu.edu.cn)
#   Date    : 01/19/07
#   transformed and modified from Matlab to Python by Maximilian Koschay
#   changed to one dimension

    # Generate Laplacian noise
    u = np.random.rand(m)-0.5;
    b = sigma / np.sqrt(2);
    y = mu - b * np.sign(u) * np.log(1- 2* np.abs(u));
    
    return y
