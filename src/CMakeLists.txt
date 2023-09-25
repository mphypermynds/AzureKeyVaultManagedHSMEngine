cmake_minimum_required(VERSION 3.10)

# set the project name
project(e_akv)

set(eakv_src
  ctrl.c
  dllmain.c
  e_akv_err.c
  key.c
  rsa.c
  ec.c
  base64.c
  curl.c
  pch.c
  )
add_library(eakv_obj OBJECT ${eakv_src})
set_property(TARGET eakv_obj PROPERTY POSITION_INDEPENDENT_CODE 1)
add_library(eakv SHARED $<TARGET_OBJECTS:eakv_obj>)
set_target_properties(eakv
  PROPERTIES OUTPUT_NAME e_akv PREFIX "" SUFFIX ${CMAKE_SHARED_LIBRARY_SUFFIX}
  )
find_library(SSL_LIB libssl${CMAKE_SHARED_LIBRARY_SUFFIX} REQUIRED)
find_library(CRYPTO_LIB libcrypto${CMAKE_SHARED_LIBRARY_SUFFIX} REQUIRED)
find_library(CURL_LIB libcurl${CMAKE_SHARED_LIBRARY_SUFFIX} REQUIRED)
find_library(JSONC_LIB libjson-c${CMAKE_SHARED_LIBRARY_SUFFIX} REQUIRED)
target_link_libraries(eakv
  ${CRYPTO_LIB}
  ${SSL_LIB}
  ${CURL_LIB}
  ${JSONC_LIB}
  )
target_include_directories(eakv_obj
    PUBLIC "/opt/homebrew/opt/openssl/include"
           "/opt/homebrew/opt/json-c/include"
)
install(TARGETS eakv DESTINATION "/usr/lib/x86_64-linux-gnu/engines-1.1")
