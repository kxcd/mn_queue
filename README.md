# mn_queue
Determine DASH Masternode's position in payment queue


This script requires dash-cli to be in your path, verify it is with:
`which dash-cli`

If that gives you an error adjust your PATH varible in ~/.profile to include it.

Run the code with

    . ./mn_queue.sh
    mn_queue

This will print the masternodes in order of their priority for payment in the queue, the top 10% are choosen at random, so if the network has 4600 MNs, then the next MN to be paid is choosen at random from those in postion 1-460.  That said, a MN higher up that list is more likely to get paid next than one lower in the list simply because it has been there for longer.  Also, remember that until the release of 12.4 each MN has a slightly different view of the network, so running this code of different MNs may give a different ranking for the same MN.  So, this code is a rough guide of how your MN is progressing through the queue.

To filter the list to your MN, execute the command like so,

    mn_queue | grep Xt8UsKZEhJs6nG1j9gzWHWcuEHaKm6xPrA

Replacing with your actual MN public key.  The first number in the list is the postion in the queue the other numbers can be ignored and in a future version I may clean up the output.

To permanently add this function to your bash start up files, do the following.

    cd /tmp
    git clone https://github.com/kxcd/mn_queue/
    cd mn_queue
    echo >> ~/.bashrc
    tail -n +17 mn_queue.sh >> ~/.bashrc

Logout and back in and test it with `mn_queue` you should see the current list print to the screen.
