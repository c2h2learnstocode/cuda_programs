#include <stdio.h>
#include <stdlib.h>



void init(float *x, int s){
    int i=0;
    for(i=0; i<s; i++){
        x[i]=1.0f * (float)i;
    }
}


__global__
void compute(float *x, float *y, int s){
    int i=0;
    for(i=0; i<s; i++){
      y[i]= x[i]*x[i]; 
    }
}

int main(){
    int N = 1<<20;
    
    float *x;// = malloc(sizeof(float)*N);
    float *y;// = malloc(sizeof(float)*N);
    
    cudaMallocManaged(&x, sizeof(float)*N);
    cudaMallocManaged(&y, sizeof(float)*N);

    init(x, N);
    init(y, N);
    int i=0;
    compute<<<1,1>>>(x, y, N);

    cudaDeviceSynchronize();

    for(i=0; i<N; i++){
        printf("%d %f %f\n", i, x[i], y[i]);

    }
}
