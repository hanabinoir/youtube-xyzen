// Check if the target is defined
const isDefined = v => v !== null && v !== undefined;

// Skip video adsDefined
const skipVideo = () => {
  const ad = [...document.querySelectorAll('.ad-showing')][0];
  if (!isDefined(ad)) {
    return;
  }

  const video = document.querySelector('video');
  if (!isDefined(video) || isNaN(video.duration)) {
  	console.log('Ad video not playing.');
    return;
  } else if (video.currentTime < video.duration) {
    video.currentTime = video.duration;
    console.log(`Ad in ${video.duration} is skipped`);
  }
  console.log(`Ad process: ${video.currentTime}/${video.duration}`)

}

// Remove the banners
const removeBanners = () => {
  const promoted = document.getElementById('YtSparklesVisibilityIdentifier');
  const footer = document.getElementsByClassName('companion-ad-container')[0];
  [promoted, footer].forEach( ad => {
  	if (isDefined(ad)) {
      ad.remove();
      console.log(`${ad.tagName}[${ad.className}] removed.`);
    }
  });
}

const clear = () => {
	if (location.href.includes('searching')) {
    console.log('Search box is showing.');
    return;
  }

	const clearAds = () => {
  	if (location.href.includes('watch')) {
  		skipVideo();
    	removeBanners();
  	} else if (location.href.includes('search_query')) {
  		const banner = document.getElementsByClassName('promoted-sparkles-text-search-root-container')[0];
      if (defined(banner)) {
      	banner.remove();
        console.log('Search page banner removed');
      }
  	}
  }
	const timeout = setInterval(() => {
  	clearAds();
  }, 500);

  return () => {
  	clearInterval(timeout);
  }
}

// MutatonObserver
const config = { attributes: true, childList: true, subtree: true };
const callback = (mutations, observer) => {
	if (document.readyState !== 'complete') { return; }

	mutations.forEach( mutation => {
  	if (mutation.type === 'childList') {
    	clear();
    }
  })
};


const onUrlChange = () => {
  console.log(`URL: ${location.href}`);
  if (!location.href.includes('watch')) { return; }

  const target = document.getElementsByClassName('page-container')[0];
  const observer = new MutationObserver(callback);
  observer.observe(target, config);
}

let lastUrl = location.href;
