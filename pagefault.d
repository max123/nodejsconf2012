#!/usr/sbin/dtrace -s

#pragma D option flowindent

pagefault:entry
/execname == $$1/
{
	printf("fault occurred on address = %p\n", args[0]);
	self->in = 1;
}

pagefault:return
/self->in == 1/
{
	self->in = 0;
	exit(0);
}

entry
/self->in == 1/
{
}

return
/self->in == 1/
{
}

