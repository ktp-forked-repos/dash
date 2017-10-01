# Generate and install DASH compiler wrapper




# prepare additional libraries variable
set(ADDITIONAL_LIBRARIES_WRAP "")
foreach (ADDITIONAL_LIB ${ADDITIONAL_LIBRARIES})
  #string(REGEX MATCH "^/.*$" IS_ABSOLUTE_PATH ${ADDITIONAL_LIB})
  #if (${IS_ABSOLUTE_PATH})
  if (${ADDITIONAL_LIB} MATCHES "^/.*$")
    set(ADDITIONAL_LIBRARIES_WRAP
      "${ADDITIONAL_LIBRARIES_WRAP} ${ADDITIONAL_LIB}")
  else()
    set(ADDITIONAL_LIBRARIES_WRAP
      "${ADDITIONAL_LIBRARIES_WRAP} -l${ADDITIONAL_LIB}")
  endif()
endforeach()

set(CXXFLAGS_WRAP "${CXXFLAGS}")

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
  set(CXXFLAGS_WRAP "${CXXFLAGS_WRAP} ${CMAKE_CXX_FLAGS_DEBUG}")
else ()
  set(CXXFLAGS_WRAP "${CXXFLAGS_WRAP} ${CMAKE_CXX_FLAGS_RELEASE}")
endif()


if (";${DART_IMPLEMENTATIONS_LIST};" MATCHES ";mpi;")
  set(DASHCC ${MPI_CXX_COMPILER})
  set(DART_IMPLEMENTATION "mpi")
  configure_file(
    ${CMAKE_SOURCE_DIR}/dash/scripts/dashcc/dashcxx.in
    ${CMAKE_BINARY_DIR}/bin/dash-mpicxx
    @ONLY)

  install(
    FILES ${CMAKE_BINARY_DIR}/bin/dash-mpicxx
    DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
    PERMISSIONS OWNER_WRITE OWNER_READ GROUP_READ WORLD_READ
                OWNER_EXECUTE GROUP_EXECUTE WORLD_EXECUTE)

  install(CODE "execute_process(
    COMMAND ${CMAKE_COMMAND} -E create_symlink dash-mpicxx dash-mpiCC
    WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX}/bin/
    )"
  )

  install(CODE "execute_process(
    COMMAND ${CMAKE_COMMAND} -E create_symlink dash-mpicxx dash-mpic++
    WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX}/bin/
    )"
  )
endif()


if (";${DART_IMPLEMENTATIONS_LIST};" MATCHES ";shmem;")
  set(DASHCC ${CMAKE_CXX_COMPILER})
  set(DART_IMPLEMENTATION "shmem")
  configure_file(
    ${CMAKE_SOURCE_DIR}/dash/scripts/dashcc/dashcxx.in
    ${CMAKE_BINARY_DIR}/bin/dash-shmemcxx
    @ONLY)

  install(
    FILES ${CMAKE_BINARY_DIR}/bin/dash-shmemcxx
    DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
    PERMISSIONS OWNER_WRITE OWNER_READ GROUP_READ WORLD_READ
                OWNER_EXECUTE GROUP_EXECUTE WORLD_EXECUTE)

  install(CODE "execute_process(
    COMMAND ${CMAKE_COMMAND} -E create_symlink dash-shmemcxx dash-shmemCC
    WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX}/bin/
    )"
  )

  install(CODE "execute_process(
    COMMAND ${CMAKE_COMMAND} -E create_symlink dash-shmemcxx dash-shmemc++
    WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX}/bin/
    )"
  )
endif()
