<script lang="ts">
	import { currentUser } from '$lib/pocketbase';
	import Tag from '$lib/Tag.svelte';
	import SmallDropdown from '$lib/SmallDropdown.svelte';
	import HoverDropdown from '$lib/HoverDropdown.svelte';
	import { onMount, beforeUpdate } from 'svelte';

	export let id: string;
	export let authorId: string;
	export let authorAvatar: any;
	export let content: string;
	export let tags: string;
	export let author: string;
	export let date: string;
	export let likes: string[] = [];
	export let onLike: (id: string) => void;
	export let onUnlike: (id: string) => void;
	export let onDelete: (id: string) => void;

	let tagArr: string[] = [];
	let userLiked: boolean = false;
	let showPostDropdown: boolean = false;
	let showLikesDropdown: boolean = false;

	function togglePostDropdown() {
		showPostDropdown = !showPostDropdown;
	}

	function onLikeClicked(id: string) {
		if (userLiked) onUnlike(id);
		else onLike(id);
	}

	onMount(() => {
	});

	beforeUpdate(() => {
		if ($currentUser == null) return;
		userLiked = likes.includes($currentUser.id);
	});
</script>

<div class="relative">
	{#if showPostDropdown}
		<SmallDropdown onDelete={() => onDelete(id)} showDelete={$currentUser?.id === authorId} />
	{/if}
	<div class="bg-[#333333] w-[500px] rounded-md drop-shadow-md text-white p-5">
		<div class="flex items-center justify-between mb-2">
			<div class="flex items-center">
				<img
					src={authorAvatar}
					alt="Profile Icon"
					class="h-10 w-10 object-cover mr-3 hover:cursor-pointer rounded-full bg-white"
				/>
				<div class="flex flex-col">
					<button
						class="font-semibold hover:underline cursor-pointer text-left"
						on:click={() =>
							window.location.assign(`http://${window.location.host}/user/${authorId}`)}
						>{author}</button
					>
					<h4 class="text-sm text-neutral-300">{date}</h4>
				</div>
			</div>
			<div class="flex space-x-2">
				<button on:click={() => onLikeClicked(id)}>
					{#if userLiked}<img
							src="/heart-full.svg"
							alt="Dot Dot Dot"
							class="w-4 hover:cursor-pointer"
						/>{:else}<img
							src="/heart.svg"
							alt="Dot Dot Dot"
							class="w-4 hover:cursor-pointer"
						/>{/if}</button
				>
				<button
					on:click={togglePostDropdown}
					class="w-8 h-8 flex items-center justify-center rounded-full hover:bg-neutral-600"
				>
					<img src="/dots.svg" alt="Dot Dot Dot" class="w-4 hover:cursor-pointer" />
				</button>
			</div>
		</div>

		<p class="mb-4">
			{content}
		</p>

		<div class="relative text-sm flex text-neutral-300 justify-between mb-4">
			<p
				class="hover:underline cursor-pointer"
				on:pointerenter={() => (showLikesDropdown = true)}
				on:pointerleave={() => (showLikesDropdown = false)}
			>
				{likes?.length} likes
			</p>
			{#if showLikesDropdown}
			<HoverDropdown>
				(call back to page and show load state while gathering most recent likes)
			</HoverDropdown>
			{/if}
		</div>

		{#if tagArr.length > 0}
			<div class=" flex space-x-2 mb-4 flex-wrap">
				{#each tagArr as tag}
					<Tag label={tag} />
				{/each}
			</div>
		{/if}


	</div>
</div>
