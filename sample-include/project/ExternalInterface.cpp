#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include <hxcpp.h>

extern "C" void project_include_main () {
	val_int(0); // Fix Neko init
}
DEFINE_ENTRY_POINT (project_include_main);

extern "C" int project_include_register_prims () {
	return 0;
}
