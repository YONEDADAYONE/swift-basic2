readonly MODULEMAP="${PODS_ROOT}/TwitterCore/iOS/TwitterCore.framework/Modules/module.private.modulemap"
readonly HEADER="${PODS_ROOT}/TwitterCore/iOS/TwitterCore.framework/Headers/TwitterCore.h"

if ! grep -q "TwitterCore_Private" "${MODULEMAP}"; then
cat >"${MODULEMAP}" <<EOL
module TwitterCore_Private {
}
EOL
fi

if ! grep -q "TWTRColorUtil.h" "${HEADER}"; then
cat >>"${HEADER}" <<EOL
#import "TWTRColorUtil.h"
EOL
fi
