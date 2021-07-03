const fs = require("fs"),
      path = require("path"),
      glob = require("glob"),
      mkdirp = require('mkdirp'),
      simpleGit = require('simple-git'),
      git = simpleGit(),
      readJSON = _path => {
        if (!fs.existsSync(_path)) return null;
        return JSON.parse(fs.readFileSync(_path))
      },
      writeJSON = (_path, _object) => {
        mkdirp.sync(path.dirname(_path));
        return fs.writeFileSync(_path, JSON.stringify(_object, null, 2))
      },
      repoBaselinePath = "versions/baseline.json"

// ------------------------------------------------------------

const vcpkgJsonFiles = glob.sync("ports/**/vcpkg.json"),
      versionsBaseline = readJSON(repoBaselinePath) || {default: {}}

async function run()
{
  await Promise.all(
    vcpkgJsonFiles.map(async vcpkgFile => {
      const port = readJSON(vcpkgFile),
            portPath = path.dirname(vcpkgFile),
            portName = path.basename(portPath)

      try {
        const portHash = await git.revparse([`HEAD:${portPath}`]),
              portVersionPath = `versions/${portName.substring(0, 1).toLowerCase()}-/${portName}.json`

        // baseline
        if (!versionsBaseline.default[portName])
        {
          versionsBaseline.default[portName] = {
            baseline: port.version,
            "port-version": port["port-version"] || 0
          }
        }

        // versions
        let portVersion = {versions: [{}]};

        if (fs.existsSync(portVersionPath)) portVersion = readJSON(portVersionPath);

        portVersion.versions[0] = {
          "git-tree": portHash,
          version: port.version
        };

        writeJSON(portVersionPath, portVersion);

        console.log(`Port '${portName}' successfully added to the repository.`);
      }
      catch (ex) {
        console.log(`Could not add port '${portName}' to the repository. Reason:`, ex);
      }
    })
  );

  writeJSON(repoBaselinePath, versionsBaseline);

  console.log(`\nRemember to 'git add versions && git commit --amend'!`);
}

run();
