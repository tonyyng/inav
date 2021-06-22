set -e

if [[ $# == 0 ]]; then
  set -- "NOX_SS MATEKF411SE MATEKF411 KAKUTEF7HDV HGLRCF722"
fi

if [ -z "$(docker images -q inav-build)" ]; then
  echo -e "*** Building image\n"
  docker build -t inav-build .
  echo -ne "\n"
fi

if [ ! -d ./build ]; then
  echo -e "*** Creating build directory\n"
  mkdir ./build
fi

echo -e "*** Building targets [$@]\n"
docker run --rm -it -v "$(pwd)":/src inav-build $@

if ls ./build/*.hex &> /dev/null; then
  echo -e "\n*** Built targets in ./build:"
  stat -c "%n (%.19y)" ./build/*.hex
fi
