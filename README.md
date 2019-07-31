# fftw-build
FFTW build solutions and precompiled libraries for linux/android/ios/macos/windows.

## Precompiled libraries (all with enabled float, you have to rebuild yourself for double or long double)
1. Get precompiled library for ***linux*** from [this git repository](https://github.com/godock/fftw-build/tree/master/library/linux).  
2. Get precompiled library for ***android*** from [this git repository](https://github.com/godock/fftw-build/tree/master/library/android).  
3. Get precompiled library for ***ios*** from [this git repository](https://github.com/godock/fftw-build/tree/master/library/ios).  
4. Get precompiled library for ***macos*** from [this git repository](https://github.com/godock/fftw-build/tree/master/library/macos).  
5. Get precompiled library for ***windows*** from [fftw.org windows install page](http://fftw.org/install/windows.html) ***or*** [this git repository](https://github.com/godock/fftw-build/tree/master/library/win_vs2012).  

## Build Solutions
Prepare fftw source from [fftw.org download](http://fftw.org/download.html).  

#### 1. Build FFTW for Linux/Android/IOS/MacOS  
Copy its buildscript in [build folder](https://github.com/godock/fftw-build/tree/master/build) to fftw source folder and run to generate the library.  

#### 2. Build FFTW for Windows  
Copy [fftw-windows-vs2012](https://github.com/godock/fftw-build/tree/master/build/fftw-windows-vs2012) to fftw source folder and then load the fftw-3.6-libs.sln by visual studio 2012.  
