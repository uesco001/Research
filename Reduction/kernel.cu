
// Define your kernels in this file you may use more than one kernel if you
// need to

// INSERT KERNEL(S) HERE
#define BLOCK_SIZE 512
__global__ void reduction(float *out, float *in, unsigned size)
{
    /********************************************************************
    Load a segment of the input vector into shared memory
    Traverse the reduction tree
    Write the computed sum to the output vector at the correct index
    ********************************************************************/

    // INSERT KERNEL CODE HERE


	float sdata[];
	unsigned i = threadIdx.x + blockIdx.x * blockDim.x;
	// stride is total number of threadsi
	unsigned tid = threadIdx.x;
	// All threads handle blockDim.x * gridDim.x
	// consecutive elements
	sdata[tid] = in[i];
	_syncthreads();
	
	for( unsigned s = 1; s < blockDim.x; s *=2)
	{
		if(tid%(2*s) == 0)
		{
			sdatat[tid] += sdata[tid + s];
		}
		_synchthreads();
	}
	
	if(tid == 0){ out[blockIdx.x] = sdata[0];}

}
