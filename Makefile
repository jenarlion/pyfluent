style:
	@echo "Running code style"
	@pre-commit run --all-files --show-diff-on-failure

install:
	@pip install -r requirements/requirements_build.txt
	@poetry build
	@pip install -q --force-reinstall dist/*.whl

install-test:
	@pip install -r requirements/requirements_build.txt
	@poetry install --with test
	@poetry install -E reader
	@poetry run python -m pip install -q --force-reinstall dist/*.whl > /dev/null

version-info:
	@bash -c "date -u +'Build date: %B %d, %Y %H:%M UTC ShaID: <id>' | xargs -I date sed -i 's/_VERSION_INFO = .*/_VERSION_INFO = \"date\"/g' src/ansys/fluent/core/__init__.py"
	@bash -c "git --no-pager log -n 1 --format='%h' | xargs -I hash sed -i 's/<id>/hash/g' src/ansys/fluent/core/__init__.py"

docker-pull:
	@bash .ci/pull_fluent_image.sh

test-import:
	@python -c "import ansys.fluent.core as pyfluent"

PYTESTEXTRA = --cache-clear --cov=ansys.fluent --cov-report=xml:cov_xml.xml --cov-report=html
PYTESTRERUN = --last-failed --last-failed-no-failures none

unittest: unittest-dev-242

unittest-dev-222:
	@echo "Running unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --fluent-version=22.2 $(PYTESTEXTRA) || poetry run python -m pytest --fluent-version=22.2 $(PYTESTRERUN)

unittest-dev-231:
	@echo "Running unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --fluent-version=23.1 $(PYTESTEXTRA) || poetry run python -m pytest --fluent-version=23.1 $(PYTESTRERUN)

unittest-dev-232:
	@echo "Running unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --fluent-version=23.2 $(PYTESTEXTRA) || poetry run python -m pytest --fluent-version=23.2 $(PYTESTRERUN)

unittest-dev-241:
	@echo "Running unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --fluent-version=24.1 $(PYTESTEXTRA) || poetry run python -m pytest --fluent-version=24.1 $(PYTESTRERUN)

unittest-dev-242:
	@echo "Running unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --fluent-version=24.2 $(PYTESTEXTRA) || poetry run python -m pytest --fluent-version=24.2 $(PYTESTRERUN)

unittest-dev-251:
	@echo "Running unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --fluent-version=25.1 $(PYTESTEXTRA) || poetry run python -m pytest --fluent-version=25.1 $(PYTESTRERUN)

unittest-all-222:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=22.2 $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=22.2 $(PYTESTRERUN)

unittest-all-222-no-codegen:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=22.2 -m "not codegen_required" $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=22.2 -m "not codegen_required" $(PYTESTRERUN)

unittest-all-231:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=23.1 $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=23.1 $(PYTESTRERUN)

unittest-all-231-no-codegen:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=23.1 -m "not codegen_required" $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=23.1 -m "not codegen_required" $(PYTESTRERUN)

unittest-all-232:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=23.2 $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=23.2 $(PYTESTRERUN)

unittest-all-232-no-codegen:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=23.2 -m "not codegen_required" $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=23.2 -m "not codegen_required" $(PYTESTRERUN)

unittest-all-241:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=24.1 $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=24.1 $(PYTESTRERUN)

unittest-all-241-no-codegen:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=24.1 -m "not codegen_required" $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=24.1 -m "not codegen_required" $(PYTESTRERUN)

unittest-all-242:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=24.2 $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=24.2 $(PYTESTRERUN)

unittest-all-242-no-codegen:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=24.2 -m "not codegen_required" $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=24.2 -m "not codegen_required" $(PYTESTRERUN)

unittest-all-251:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=25.1 $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=25.1 $(PYTESTRERUN)

unittest-solvermode-251:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --fluent-version=25.1 --solvermode $(PYTESTEXTRA) || poetry run python -m pytest --fluent-version=25.1 --solvermode $(PYTESTRERUN)

unittest-all-251-no-codegen:
	@echo "Running all unittests"
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@poetry run python -m pytest --nightly --fluent-version=25.1 -m "not codegen_required" $(PYTESTEXTRA) || poetry run python -m pytest --nightly --fluent-version=25.1 -m "not codegen_required" $(PYTESTRERUN)

api-codegen:
	@echo "Running API codegen"
	@python -m venv env
	@. env/bin/activate
	@pip install -q -e .
	@python codegen/allapigen.py
	@rm -rf env

build-doc-source:
	@sudo rm -rf doc/source/api/meshing/datamodel
	@sudo rm -rf doc/source/api/meshing/tui
	@sudo rm -rf doc/source/api/solver/datamodel
	@sudo rm -rf doc/source/api/solver/tui
	@sudo rm -rf doc/source/api/solver/_autosummary/settings
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@xvfb-run poetry run -- make -C doc html

build-all-docs:
	@python doc/datamodel_rstgen.py
	@python doc/tui_rstgen.py
	@python doc/settings_rstgen.py
	@sudo rm -rf /home/ansys/.local/share/ansys_fluent_core/examples/*
	@xvfb-run poetry run -- make -C doc html

compare-flobject:
	@python .ci/compare_flobject.py

cleanup-previous-docker-containers:
	@if [ -n "$(docker ps -a -q)" ]; then docker stop $(docker ps -a -q); fi
	@if [ -n "$(docker ps -a -q)" ]; then docker rm -vf $(docker ps -a -q); fi
