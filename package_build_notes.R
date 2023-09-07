# package build commands

# You will call these functions on a regular basis, as you add functions and
# tests or take on dependencies:

use_r()
use_test()
use_package()
use_article()

# You will call these functions multiple times per day or per hour, during
# development:

load_all()
document()
test()
check() # aka R CMD check

# others
build_readme()
build_vignettes()

# for cran submission
use_release_issue()
devtools::check(remote = TRUE, manual = TRUE)
check_win_devel()

