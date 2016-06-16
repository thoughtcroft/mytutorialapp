pkg_origin=thoughtcroft
pkg_name=mytutorialapp
pkg_version=0.1.0
pkg_maintainer="Warren Bain <warren@thoughtcroft.com>"
pkg_license=()
pkg_source=https://s3-us-west-2.amazonaws.com/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=b54f8ada292b0249245385996221751f571e170162e0d464a26b958478cc9bfa
pkg_deps=(core/node)
pkg_expose=(8080)


do_build() {
  # The mytutorialapp source code is unpacked into a directory,
  # mytutorialapp-0.1.0, at the root of $HAB_CACHE_SRC_PATH. If you were downloading
  # an archive that didn't match your package name and version, you would have to
  # copy the files into $HAB_CACHE_SRC_PATH.

  # This installs both npm as well as the nconf module we listed as a
  # dependency in package.json.
  npm install
}

do_install() {
  # Our source files were copied over to the HAB_CACHE_SRC_PATH in do_build(),
  # so now they need to be copied into the root directory of our package through
  # the pkg_prefix variable. This is so that we have the source files available
  # in the package.
  cp package.json ${pkg_prefix}
  cp server.js ${pkg_prefix}

  # Copy over the nconf module to the package that we installed in do_build().
  mkdir -p ${pkg_prefix}/node_modules/
  cp -vr node_modules/* ${pkg_prefix}/node_modules/
}
