<script lang="ts">
	import { currentUser, pb, getImageURL } from '$lib/pocketbase';
	import { page } from '$app/stores';
	import { onMount, beforeUpdate } from 'svelte';
	import EditModal from '$lib/EditModal.svelte';
	import SmallPost from '$lib/SmallPost.svelte';

	let viewedUser: any = '';
	let showModal: boolean = false;
	let postList: any = [];

	beforeUpdate(async () => {
		if (!$currentUser) return;
		followIds = $currentUser.following;
		followList = $currentUser.expand?.following || [];
	});

	onMount(async () => {
		try {
			viewedUser = await pb.collection('users').getOne($page.params.userid, {
				expand: 'posts'
			});
		} catch (err) {
			console.error(err);
		}
		postList = viewedUser.expand?.posts || [];
	});

	function toCapitalize(string: string) {
		return string.charAt(0).toLocaleUpperCase() + string.slice(1).toLocaleLowerCase();
	}

	async function updateProfile(first: string, last: string, bio: string, photo: any) {
		if ($currentUser == null) return;

		const formData = new FormData();

		if (bio) formData.append('bio', bio);
		if (first && last) formData.append('name', `${toCapitalize(first)} ${toCapitalize(last)}`);
		if (photo) formData.append('avatar', photo);

		if (!formData) return;

		closeModal();
		await pb.collection('users').update($currentUser.id, formData);
	}

	function closeModal() {
		showModal = false;
	}

	function openModal() {
		showModal = true;
	}

	let followIds: any = [];
	let followList: any = [];

	async function followUser(id: string) {
		//follow user
		if ($currentUser == null) return;

		if (followIds.includes(viewedUser.id)) return;

		let following = [viewedUser.id, ...followIds];

		const data = {
			following: following
		};

		let newUser = await pb.collection('users').update($currentUser.id, data, {
			expand: 'following'
		});

		followIds = following;
		followList = newUser.expand.following;

		//other user receives follow (CURRENTLY NOT PROTECTED AT ALL, super dumb and not safe***)

		let followers = [...viewedUser.followers, $currentUser.id];

		const receiveData = {
			followers: followers
		};

		await pb.collection('users').update(viewedUser.id, receiveData);
	}

	async function deletePost(id: string) {
		postList = postList.filter((post: any) => post.id !== id);

		await pb.collection('posts').delete(id);
	}

	async function likePost(id: string) {
		if ($currentUser == null) return;

		let post = postList.filter((post: any) => post.id == id)[0];

		let likes = [...post.likes, $currentUser.id];

		const data = {
			likes: likes
		};

		postList = postList.map((posts: any) => {
			if (posts.id == post.id) posts.likes = likes;
			return posts;
		});

		await pb.collection('posts').update(id, data);
	}

	async function unlikePost(id: string) {
		if ($currentUser == null) return;

		let post = postList.filter((post: any) => post.id == id)[0];

		let removalIndex = post.likes.indexOf($currentUser.id);

		post.likes.splice(removalIndex, 1);

		let likes = post.likes;

		const data = {
			likes: likes
		};

		postList = postList.map((posts: any) => {
			if (posts.id == post.id) posts.likes = likes;
			return posts;
		});

		await pb.collection('posts').update(id, data);
	}
</script>

{#if viewedUser === ''}
	<!--Load state-->
{:else if viewedUser}
	{#if showModal}<EditModal
			currentAvatar={$currentUser?.avatar ? getImageURL(
				$currentUser?.collectionId,
				$currentUser?.id || '',
				$currentUser?.avatar
			) : '/profile.svg'}
			onSave={(first, last, bio, photo) => updateProfile(first, last, bio, photo)}
			onClose={closeModal}
		/>
	{/if}
	<div class="">
		<div
			class="px-16 pt-24 pb-8 mb-4 bg-[#2e2e2e] flex justify-between items-center drop-shadow-sm"
		>
			<div class="flex space-x-6 items-center ">
				{#if viewedUser?.avatar}
					<img
						src={getImageURL(
							viewedUser?.collectionId,
							viewedUser?.id || '',
							viewedUser?.avatar
						) || "/profile.svg"}
						alt="Profile Icon"
						class="w-20 h-20 object-cover hover:cursor-pointer bg-white rounded-full"
					/>
				{:else}
					<img
						src="/profile.svg"
						alt="Profile Icon"
						class="w-20 hover:cursor-pointer bg-white rounded-full"
					/>
				{/if}

				<div>
					<div class="flex space-x-1 items-center">
						<h1 class="font-semibold text-white text-2xl">{viewedUser?.username}</h1>
						{#if viewedUser?.verified}<img src="/verified.svg" alt="Verified" class="w-5" />
						{/if}
					</div>
					{#if $currentUser?.id == viewedUser?.id}
						<h2 class=" text-neutral-300">
							{$currentUser?.name}
						</h2>
					{:else if viewedUser?.name}
						<h2 class=" text-neutral-300">
							{viewedUser?.name}
						</h2>
					{/if}
					<div class="text-[#49b4b1] text-sm font-semibold flex space-x-2 mt-1">
						<h2 class="hover:underline cursor-pointer">
							{viewedUser?.followers?.length} Followers
						</h2>
						<h2 class="hover:underline cursor-pointer">
							{viewedUser?.following?.length} Following
						</h2>
					</div>
				</div>
			</div>
			{#if $currentUser?.id == viewedUser?.id}
				<button
					class="flex space-x-2 items-center rounded-md bg-neutral-700 p-2 px-4"
					on:click={openModal}
				>
					<img src="/edit.svg" alt="Edit Pen" class="w-4" />
					<p class="text-neutral-300 font-semibold">Edit Profile</p></button
				>
			{:else if $currentUser?.following.includes(viewedUser?.id)}
				<button
					class="flex space-x-2 items-center rounded-md bg-[#378E8B] hover:bg-[#2d7e7b] p-2 px-4"
				>
					<img src="/follow.svg" alt="Edit Pen" class="w-5" />
					<p class="text-neutral-300 font-semibold">Following</p></button
				>
			{:else}
				<button
					class="flex space-x-2 items-center rounded-md bg-[#378E8B] hover:bg-[#2d7e7b] p-2 px-4"
					on:click={() => followUser(viewedUser?.id)}
				>
					<img src="/follow.svg" alt="Edit Pen" class="w-5" />
					<p class="text-neutral-300 font-semibold">Follow User</p></button
				>
			{/if}
		</div>
		<div class="px-16 mb-4">
			<h3 class="text-white text-lg font-semibold mb-2">Bio:</h3>
			{#if $currentUser?.id == viewedUser?.id}
				<p class="text-neutral-300">{$currentUser?.bio || 'Nothing to see here yet'}</p>
			{:else}
				<p class="text-neutral-300">{viewedUser?.bio || 'Nothing to see here yet'}</p>
			{/if}
		</div>
		<div class="px-16">
			<h3 class="text-white text-lg font-semibold mb-4">Posts:</h3>
			{#if postList.length >= 1}
				<div class="flex flex-wrap gap-12">
					{#each postList || [] as post (post.id)}
						<SmallPost
							id={post.id}
							authorId={viewedUser.id}
							authorAvatar={viewedUser?.avatar ? getImageURL(
								viewedUser?.collectionId,
								viewedUser?.id || '',
								viewedUser?.avatar
							) : "/profile.svg"}
							author={viewedUser.username}
							date={post?.date}
							content={post?.content}
							tags={post?.tags}
							likes={post?.likes}
							onLike={(id) => likePost(id)}
							onUnlike={(id) => unlikePost(id)}
							onDelete={(id) => deletePost(id)}
						/>
					{/each}
				</div>
			{:else}
				<p class="text-neutral-300">Nothing to see here yet</p>
			{/if}
		</div>
	</div>
{:else}
	<div class="text-white flex justify-center items-center h-screen flex-col space-y-12">
		<h1 class="font-semibold text-3xl">This page can not be found</h1>
		<button
			class="rounded-md text-[#378E8B] underline text-lg hover:font-semibold"
			on:click={() => window.location.assign(`http://${window.location.host}/home`)}
			>Return home</button
		>
	</div>
{/if}
