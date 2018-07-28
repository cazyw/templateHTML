# Helpful tips and code

Sections:
* [Amazon Web Services](#amazon-web-services)
* [Certificates](#certificates)
* [Chrome Browser](#chrome-browser)
* [Chrome Extensions](#chrome-extensions)
* [Docker](#docker)
* [Fiddler](#fiddler)
* [Git](#git)
* [Internet Information Services](#internet-information-services)
* [Javascript](#javascript)
* [Markdown](#markdown)
* [Powershell](#powershell)
* [Selenium](#selenium)
* [Testing](#testing)
* [Browsermob and Selenium](#browsermob-and-selenium)

## Amazon Web Services

### IAM

Within the root account, set up IAM accounts. Remember to add an **alias** (friendly name) otherwise you'll need to use the 12 digit account. Within each account you can have multiple IAM user accounts.

To register/use domain names, use Route53.

### Security and Elastic Load Balancer‎
By placing resources behind an elastic load balancer, requests for resources can be balanced amongst a number of instances. For example, requests for content can be spread amongst a number of EC2 instances. Security can also be placed at the ELB level with SSL certificates installed at this external facing level.

However, this means that if your resource behind the ELB is trying to determine whether the request came from a secure network (https), the outcome will always be false as the network between the ELB and the instance is in http.

AWS ELB however can forward the protocol used between the external client and ELB. This can be used to determine whether the request came over a secure network.

Check whether `HTTP_X_FORWARDED_PROTO = https`

## Certificates

For working in a **dev** environment that needs both creating a root certificate authority and signed certificate using OpenSSL in Powershell. Download OpenSSL (get via chocolatey)

1. Create the private key for the root certificate authority
1. Create the root certificate based on this private key
1. Create a private key for the certifiate to be signed by this authority
1. Create the signing request (must fill in the **common name** field)
1. Greate the certificate with the root cert and key
1. package both the private keys and certs in encrypted p12 files

NB: when using the below code, the common name for the root authority and the cert being signed by the root authority should not be the same

```Powershell
openssl genrsa -des3 -out rootCA.key 4096
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.crt

openssl genrsa -out domainCert.key 2048
openssl req -new -key domainCert.key -out domainCert.csr
openssl x509 -req -in domainCert.csr -CA rootCA.crt -CAkey rootCA.key -out domainCert.crt -days 1024 -sha256

openssl pkcs12 -export -out rootCA.p12 -inkey rootCA.key -in rootCA.crt
openssl pkcs12 -export -out domainCert.p12 -inkey domainCert.key -in domainCert.crt
```

## Chrome Browser

To default to incognito mode:

1. Save a shortcut to the desktop
1. add ` -incognito` to the end of the path e.g. `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -incognito`

## Chrome Extensions

For a useful template/guide, see:

* Part 1: https://medium.com/@gilfink/building-a-chrome-extension-using-react-c5bfe45aaf36
* Part 2: https://medium.com/@gilfink/adding-web-interception-abilities-to-your-chrome-extension-fb42366df425
* Part 3: https://medium.com/@gilfink/using-messaging-in-chrome-extension-4ae65c0622f6

## Docker

See [Docker](https://github.com/cazyw/templates-configs-tools/blob/master/notes/Docker.md)

## Fiddler

Fiddler can be used to both capture/read web traffic and also overwrite existing code (in the current view) in order to test and debug code on a page.

### Reading Traffic

Fiddler will read traffic in all open browsers/pages. By default, only http traffic is captured. In order to read https traffic,
1. Tools > Option > HTTPS
1. Select `Decrypt HTTPS traffic`
1. Accept the prompt to generate and add a certificate
1. Select `Ignore server certificate errors`

This can be quite unsafe so remember to undo any changes once it is no longer needed.

### Replace code

This is useful to test if development code will work against a live website.
You can for example
1. replace a webpage to test settings
1. replace a link to a javascript file so the page uses the local development file rather than the production file

To replace code:
1. Go to Autoresponder
1. Add a rule
1. Enter the string to match e.g. `https://blah.com/telex.js`
1. Find the file and enter the replacement file e.g. `C:\sandbox\telex_2.js`
1. Select `enable rules` and `unmatched requests passthrough` (this must be selected or no other requests will continue)

The same can be done to replace a webpage e.g.
1. String to match `www.somesite.com/index.html`
1. Replacement file `C:\sandbox\replacement\test.html`



## Git

Useful commands:
* `git rebase -i` to edit / squash commits
* `git branch -d <branch>` to delete a local branch
* `git push --set-upstream origin <branch name>` to set upstream branch once branch created
* `git remote prune origin --dry-run` (remove `--dry-run` to action) remove reference to remote if branch no longer exists on the remote
* `git fetch --prune` remove any remote-tracking references that no longer exist on the remote
* `git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD)` get the current remote tracking branch


Accidentally started working on something whilst on the master branch? (workflow below not using stash)

1. checkout and switch to a feature branch
1. commit the changes in the feature branch
1. switch back to master
1. pull from remote to get the latest version
1. switch to the feature branch
1. merge master into the feature branch
1. continue working on the feature branch

[Github Blog](https://blog.github.com/)
[Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials)
[Github Blog on Undo](https://blog.github.com/2015-06-08-how-to-undo-almost-anything-with-git/)


## Internet Information Services

This is very useful in order to create a web server / website hosted locally

1. Start IIS Manager with `inetmgr` in Run
1. Add a website
1. Add site name and host and path to physical file
1. Set bindings to 127.0.0.1
1. Running a local static site:
    * .NET CLR version: No Managed Code
    * Managed Pipeline mode: Classic
    * Advanced Settings (Identity): LocalSystem
1. Running a networked .NET site:
    * .NET CLR version: .NET CLR v4.0
    * Managed Pipeline mode: Integrated
    * Advanced Settings (Identity): NetworkService
1. Update the hosts file (C:\Windows\System32\drivers\etc) to include the IP address and host domain

## Javascript

[You Don't Know Series](https://github.com/getify/You-Dont-Know-JS)

### Async/Await

Async/await and promises are the same thing under the hood.

Every async function returns a ***promise***. Await pauses the execution, waits for the promise to be resolved and returns the value. If a function is not awaited, it will return the Promise rather than the value. This may not be obvious and only realised due to unexpected behaviour.

```Javascript
const notAwaited = getData(); // returns a promise
const awaited = await getData(); // returns the resolved promise

```

Errors are handled in try/catch blocks.

You can only await one at a time i.e. code runs sequentially
```Javascript
let foo = await getFoo();
let bar = getBar(); // waits for getFoo to finish
let hello = await getHello(); // only waits for getFoo, doesn't wait for getBar
let world = await getWorld(); // waits for getFoo and getHello
```

### Promises

A promise contains another object which are obtained using `.then` and handled when error with `.catch`. Promises force asynchronicity.

`Promise.all` will take an array of promises, and compose them all into a single promise, which resolves only when every child promise in the array has resolved itself.

```Javascript
// wait for both promises to resolve
let [foo, bar] = await Promise.all([getFoo(), getBar()]);

```

However `Promise.all` does not *create* the promises passed in, it only waits for these *already created* promises to resolve.

### Selenium

To check the cookies on the page use:

```Javascript
driver.manage().getCookies()
```
### IIFE

See https://rollupjs.org/guide/en

You can write modular javascript and then use rollup to bundle as an IIFE.
```rollup <folder>\<file>.js --format iife --name "<some name>" --file <output>.js```

## Markdown

[Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#links)

## Powershell

[Microsoft Docs](https://docs.microsoft.com/en-us/powershell/scripting/powershell-scripting?view=powershell-6)

## Sitecore

[Official Docs](http://learnsitecore.cmsuniverse.net/en/globalnavigation/sitecore-beginners-guide.aspx)

## Testing

### Mocha

When running/automating tests through a gulp file, the output displays in white. To force it to display in colour, use `-c, --colors `

#### this

When referencing other functions within a module, Node is able to identify which function is being referenced, however when running tests in Mocha (and stubbing/spying on referenced functions with sinon), Mocha gets confused and is unable to identify them.

e.g.

```Javascript
export module HealthFood {
    export function fruitSalad() {
        getFruit();
        return ....
    }

    export function getFruit() {
        ...
    }
}
```

Stubbing getVegetables [`stub(HealthFood, 'getFruit')`] will not work as `getFruit()` is called within fruitSalad. Mocha can't figure out the function being called is the one that is stubbed.

The solution is to include `this` when calling the function i.e.

```Javascript
export module HealthFood {
    export function fruitSalad() {
        this.getFruit();
        return ....
    }

    export function getFruit() {
        ...
    }
}
```

## Vim

Helpful when editing git commits in the terminal
* `i` to insert (edit)
* ```Ctrl + V``` to select the whole line
* ```d``` to yank (cut) the line
* ```:wq``` to save and exit

## Browsermob and Selenium
Helpful links:
* See Browsermob: https://github.com/lightbody/browsermob-proxy
* See OpenSSL commands: https://wiki.openssl.org/index.php/Command_Line_Utilities
* Comments about custom certs: https://groups.google.com/forum/#!topic/browsermob-proxy/ntA1ezczIa0
* Generating root CA and certs signed by this CA: https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309

Using Browsermob with Selenium. When capturing https requests, a self-signed root certificate is required for all browsers. BrowserMob Proxy uses the `ca-keystore-rsa.p12` file to load its CA Root Certificate and Private Key. For IE, the certificate (`ca-certificate-rsa.cer`) must be inserted as a Trusted Root Certificate. There are certain parameters that the browsermob proxy server expects in the keys generated: `browsermob-proxy/browsermob-core/src/main/java/net/lightbody/bmp/BrowserMobProxyServer.java`

```Java
 /* Default MITM resources */
    private static final String RSA_KEYSTORE_RESOURCE = "/sslSupport/ca-keystore-rsa.p12";
    private static final String EC_KEYSTORE_RESOURCE = "/sslSupport/ca-keystore-ec.p12";
    private static final String KEYSTORE_TYPE = "PKCS12";
    private static final String KEYSTORE_PRIVATE_KEY_ALIAS = "key";
    private static final String KEYSTORE_PASSWORD = "password";
```

Browsermob provides the root certificates here: https://github.com/lightbody/browsermob-proxy/tree/master/browsermob-core/src/main/resources/sslSupport. They include four files:
* ca-certificate-ec.cer (ignore - cert generated with Elliptic Curve Cryptography, an alternative to RSA)
* ca-keystore-ec.p12 (ignore - as above)
* ca-certificate-rsa.cer (the required certificate ***required***)
* ca-keystore-rsa.p12 (encrypted container containing the private key and certificate ***required***)

In order to use a custom generated root certificate instead of the one generated by Browsermob,
* follow the instructions at https://github.com/lightbody/browsermob-proxy/blob/master/mitm/README.md#improving-performance-with-elliptic-curve-ec-cryptography (Java) ***or***
* generate your own `.cer` and `.p12` files and replace the ones created by Browsermob (requires a bit of manual modification as the certificates are in three locations)

### Custom Root Certificate
Create the `.cer` and `.p12` files with the following commands:
```
openssl genrsa -aes128 -out ie-rCA.key 4096
openssl req -x509 -new -sha256 -days 3650 -key ie-rCA.key -out ca-certificate-rsa.cer
openssl pkcs12 -export -out ca-keystore-rsa.p12 -inkey ie-rCA.key -in ca-certificate-rsa.cer -name key
```
* `-aes128`: encrypt the generated key with cbc aes
* `4096`: The number of bits in the generated key (or use 2048)
* `-x509`: output a x509 structure instead of a cert. req.
* `-nodes`: don't encrypt the output key *taken out*
* `-sha256`: use the sha256 message digest algorithm
* `pkcs12`: contains a x509 Certificate and the public/private key of client
* `-name`: use name as friendly name/alias

Notes:
* the export password for creating the **p12** file must be `password` as this is what the proxy server expects (it extracts the cert and private key from the p12 file and expects this value - see above)
* when generating the certificate, the `Common Name` field must be completed (enter something)
* the p12 file name must be `ca-keystore-rsa.p12`
* `-name key` must be added in generating the p12 as Browsermob uses this alias to find the key

### Replace existing files
Once the two custom files are generated, replace the existing files in the following locations:
1. `/ssl-support`
1. `/browsermob-core-2.1.2-sources.jar` --> extract and replace in `/sslSupport` folder
1. `/lib/browsermob-dist-2.1.2.jar` --> extract and replace in `/sslSupport` folder
Unzip, replace and then re-zip the files (any zip program, just output to `.jar`). The `EC` files can be deleted.

### Import the certificate
Import the certificate into Trusted Root Certification Authorities (for IE).

### Programatically remove certificate
To remove in powershell (identify via thumbprint):
```
Get-ChildItem "Cert:\LocalMachine\Root\<thumbprint>" | Remove-Item
```
