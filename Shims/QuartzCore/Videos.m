// videos not playing

long CAImageQueueInsertImage(void* rdi_queue,int esi,void* rdx_surface,int ecx,void* r8_function,void* r9,double xmm0);
long CAImageQueueInsertImageWithRotation(void* rdi_queue,int esi,void* rdx,int ecx,int r8d,void* r9_function,double xmm0,void* stack)
{
	// trace(@"CAImageQueueInsertImageWithRotation %p %d %p %d %d %p %lf %p %@",rdi_queue,esi,rdx,ecx,r8d,r9_function,xmm0,stack,NSThread.callStackSymbols);

	return CAImageQueueInsertImage(rdi_queue,esi,rdx,ecx,r9_function,stack,xmm0);
}