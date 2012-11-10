#!/usr/sbin/dtrace -qs

pid$target::malloc:entry
{
	self->nbytes = arg0;
}

pid$target::malloc:return
/self->nbytes/
{
	printf("%lx: %lx malloc\n", arg1, self->nbytes);
	self->nbytes=0;
}

pid$target::free:entry
{
	printf("%lx: free\n", arg0);
}
